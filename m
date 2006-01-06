Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932347AbWAFAoY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932347AbWAFAoY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 19:44:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932340AbWAFAoY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 19:44:24 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:52935 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932347AbWAFAoV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 19:44:21 -0500
Date: Fri, 6 Jan 2006 01:40:50 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Martin Bligh <mbligh@mbligh.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Matt Mackall <mpm@selenic.com>,
       Arjan van de Ven <arjan@infradead.org>,
       Chuck Ebbert <76306.1226@compuserve.com>, Adrian Bunk <bunk@stusta.de>,
       Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Dave Jones <davej@redhat.com>,
       Tim Schmielau <tim@physik3.uni-rostock.de>
Subject: Re: [patch 00/2] improve .text size on gcc 4.0 and newer  compilers
Message-ID: <20060106004050.GA18727@elte.hu>
References: <1136463553.2920.22.camel@laptopd505.fenrus.org> <20060105170255.GK3356@waste.org> <43BD5E6F.1040000@mbligh.org> <Pine.LNX.4.64.0601051112070.3169@g5.osdl.org> <Pine.LNX.4.64.0601051126570.3169@g5.osdl.org> <43BD784F.4040804@mbligh.org> <Pine.LNX.4.64.0601051208510.3169@g5.osdl.org> <Pine.LNX.4.64.0601051213270.3169@g5.osdl.org> <20060105233049.GA3441@elte.hu> <43BDB381.6020701@mbligh.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43BDB381.6020701@mbligh.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.0 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.8 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Martin Bligh <mbligh@mbligh.org> wrote:

> >I think the only sane solution [that would be endorsed by distributions] 
> >is to allow users to reorder function sections runtime (per boot). That 
> >is alot faster and more robust (from a production POV) than a full 
> >recompilation of the kernel. Recompilation is always risky, it needs too 
> >much context, and has too many tool dependencies - and is thus currently 
> >untestable. 
> 
> <smhuch> - the sound of my eyeballs popping out and splatting against 
> the opposite wall.
> 
> So ... recompilation is not testable, but boot time reordering of the 
> code somehow is? ;-) Yes, I understand the distro toolchain issues, 
> but it's still a scary solution ...

'testable' in the sense that the stability and reliability of the system 
is alot less dependent on function ordering, than it is dependent on 
compilation. It's not 'testable' in the sense of being able to cycle 
through all the 60000-factorial function combinations - but that's not 
really a problem, as long as the risk of the worst-case effect of 
function reordering can be judged and covered. The kernel stopped being 
'fully testable' sometime around version 0.2 already ;-)

> Personally, I'd think the sane thing is not to try to optimise by 
> workload, but get 80% of the benefit by just reordering on a more 
> generalized workload. Doing boot-time reordering for this on 
> non-custom kernels just seems terrifying .. it's not that huge a 
> benefit, surely?

i'm not so sure, see the ballpark figures below.

> >one problem are modules though - they could only be reordered within 
> >themselves. On an average system which has ~100 modules loaded, the 
> >average icache fragmentation is +100*128/2 == 6.4K [with 128 byte L1 
> >cachelines], which can be significant (depending on the workload). OTOH, 
> >modules do have strong internal cohesion - they contain functions that 
> >belong together conceptually. So by reordering functions within modules 
> >we'll likely be able to realize most of the icache savings possible. The 
> >only exception would be workloads that utilize many modules at a high 
> >frequency. Such workloads will likely trash the icache anyway.
> 
> I was thinking about that with modules earlier, and whether modular 
> kernels would actually be faster because of that than a statically 
> compiled one. But don't you get similar effects from the .o groupings 
> by file we get? or does the linker not preserve those groupings?

they are mostly preserved (except for things like __sched which move 
functions out of .o), but look at a call-chain like this:

| new stack-footprint maximum: khelper/1125, 2412 bytes (out of 8140 bytes).
------------|
{   40} [<c0144a31>] debug_stackoverflow+0xb6/0xc4
{   60} [<c0144f66>] __mcount+0x47/0xe0
{   20} [<c0110b24>] mcount+0x14/0x18
{  116} [<c05fec5e>] __down_mutex+0xe/0x87b
{   28} [<c0601544>] _spin_lock+0x24/0x49
{   36} [<c015aa7e>] kmem_cache_alloc+0x40/0xe9
{   16} [<c0154ddd>] mempool_alloc_slab+0x1d/0x1f
{   56} [<c0154c82>] mempool_alloc+0x39/0xf1
{   44} [<c02f3519>] get_request+0xf7/0x2dc
{   60} [<c02f372d>] get_request_wait+0x2f/0x10f
{   88} [<c02f43bc>] __make_request+0xae/0x552
{   88} [<c02f4b9b>] generic_make_request+0xaf/0x24c
{   84} [<c02f4d90>] submit_bio+0x58/0x127
{   20} [<c0196912>] mpage_bio_submit+0x31/0x39
{  292} [<c0196d4e>] do_mpage_readpage+0x2f5/0x451
{   88} [<c0196f99>] mpage_readpages+0xef/0x19e
{   24} [<c01dfeb4>] ext3_readpages+0x2c/0x2e
{   80} [<c0158b4b>] read_pages+0x38/0x14d
{   60} [<c0158de1>] __do_page_cache_readahead+0x181/0x186
{   36} [<c0158f40>] blockable_page_cache_readahead+0x69/0xd0
{   44} [<c015918e>] page_cache_readahead+0x13c/0x185
{  120} [<c0151abf>] do_generic_mapping_read+0x436/0x6c3
{   80} [<c0151fc8>] __generic_file_aio_read+0x17f/0x22e
{   44} [<c01520c8>] generic_file_aio_read+0x51/0x7f
{  160} [<c0171091>] do_sync_read+0xba/0x109
{   40} [<c017119e>] vfs_read+0xbe/0x1a0
{   40} [<c017c5fa>] kernel_read+0x4b/0x55
{  192} [<c019f844>] load_elf_binary+0x5e9/0xd2d
{   32} [<c017d4d1>] search_binary_handler+0x80/0x136
{  176} [<c019e87e>] load_script+0x246/0x258
{   32} [<c017d4d1>] search_binary_handler+0x80/0x136
{   36} [<c017d7c2>] do_execve+0x23b/0x268
{   36} [<c0101c4e>] sys_execve+0x41/0x8f
{=2368} [<c01030ca>] syscall_call+0x7/0xb
<---------------------------

[readers beware, quick & dirty and possibly wrong guesstimations: ]

these 30 functions involve roughly 10-15 .o files, so we've got 2-3 
functions per .o file only. And that's typical for VFS, IO, networking 
and lots of other syscall types. So if the full kernel image is 3MB, and 
we've got 30 functions totalling to 3000 bytes, they are spread out in 
10-15 groups right now - creating 10-15 split icache lines. (in reality 
we have in excess of 20 split icache-lines, due to weak cohesion even 
within .o files) With 64-byte lines that's 320-480 bytes 'lost' due to 
fragmentation alone, with 128-byte lines it's 640-960 bytes - which is 
10%-21% in the 64-byte case, and 21%-42% in the 128-byte case. I.e. the 
icache bloat just due to the placement is quite significant. Adding 
.o-level fragmentation plus inter-function inactive code to the mix can 
easily baloon this even higher. Plus the current method of doing 
unlikely() means the unlikely instructions are near the end of the 
function - so they still 'spread apart' the footprint and thus have a 
nontrivial icache cost.

[ now the above one is a random example out of my logs that is also a 
  really bad example: in reality would win little from better icache 
  footprint: an execve() takes 100,000-200,000 cycles even when
  everything comes from the pagecache, and most of those cycles are
  spent in very tight codepaths. ]

	Ingo

