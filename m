Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751710AbWIYXi7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751710AbWIYXi7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Sep 2006 19:38:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751711AbWIYXi7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Sep 2006 19:38:59 -0400
Received: from e35.co.us.ibm.com ([32.97.110.153]:20704 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751709AbWIYXi5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Sep 2006 19:38:57 -0400
Date: Mon, 25 Sep 2006 19:37:50 -0400
From: Vivek Goyal <vgoyal@in.ibm.com>
To: Jean-Marc Saffroy <saffroy@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Jaroslav Kysela <perex@suse.cz>, Takashi Iwai <tiwai@suse.de>,
       Dave Anderson <anderson@redhat.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: oops in :snd_pcm_oss:resample_expand+0x19c/0x1f0
Message-ID: <20060925233750.GA9791@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
References: <Pine.LNX.4.64.0609241825280.4838@erda.mds> <20060924135417.c0c18b76.akpm@osdl.org> <Pine.LNX.4.64.0609242256540.4950@erda.mds> <20060925153047.GA19794@in.ibm.com> <Pine.LNX.4.64.0609252034030.4825@erda.mds>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0609252034030.4825@erda.mds>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 25, 2006 at 11:01:52PM +0200, Jean-Marc Saffroy wrote:
> Hi Vivek,
> 
> Thanks for all the good news on the future of kdump, it's nice to know 
> that people are working on improving the user experience.
> 
> On Mon, 25 Sep 2006, Vivek Goyal wrote:
> 
> >>>>Oh and I wish I could use gdb on a kdump core. :-)
> >
> >Currently we can use gdb but only for linearly mapped region. You are 
> >right its just a matter of re-generating the elf headers and remap the 
> >vmalloc areas to enable module debugging in gdb. I can not do it after 
> >the crash so probably the best place would be do it in user space. A 
> >program can read /proc/vmcore and regenerate the headers for enabling 
> >module debugging with gdb.
> 
> I assume that "after the crash" means "in the kernel crash handler", 
> AFAICT the current dump from vmcore has all what's needed.
> 

Yes. I mean kernel crash handler. Yes all the contents are present
in the vmcore file. It is just a matter of somebody reading vmcore
and walk through either the page tables or may be vmlist and export
these mappings through ELF headers so that gdb can read it.
 
> >Hmm.. Crash vs gdb is an interesting issue. I have not used gdb very 
> >extensively on core dumps, but with my limited experiece, I found 
> >"crash" to be more friendly.
> 
> One thing I like *very much* in gdb is its ability to display function 
> params and local variables in any stack frame, and I haven't found out how 
> to do it with crash.
> 

Agreed. AFAIK, crash does not display the function params and local
variables. gdb has got this advantage, though last time I looked
at local variables dispalyed by gdb, they seemed to be junk. Not very
sure why it was so?

> >Crash has got so many in-built commands tailored for kernel debugging 
> >and gdb lacks all those. Yes, we can write gdb scripts to implement 
> >those, but last time Alaxender Nyberg wrote few gdb scripts to dump all 
> >the threads and it was so slow.
> 
> I agree that gdb is sometimes very slow, but maybe it's easier to optimize 
> gdb than to make crash smarter?
> 

I beg to differ here. Not sure why it is easier to optimize gdb. If we
try to optimize gdb by writing scripts, then IMHO, writing C program
is easier and faster. If the idea is to optimize gdb by modifying gdb
code then its no different than crash. In fact, why to reinvent the 
wheel if crash already does so many things for us. Yes, but probably we
need to modify crash to be able to obtain function parameters and local
variables.   

> For this particular problem (listing threads), the real fix would be to 
> add the PT_NOTE entry that each thread deserves, then gdb would let you do 
> "info threads" instead, and dump nice backtraces of each.
> 

Displaying even the currently non executing threads using "info threads"
and their backtraces is interesting. Crash can already do that. I am 
apprehensive about traversing through the task list and dumping every
thread's register state after a crash. There is no gurantee that list
is in a sane state. And in general, we are trying to make crash handler
as small as possible to improve the reliability of dumping operation.

Register state of every non-executing thread is already present in the
vmcore and IMHO, we should write scripts to get info about other
threads then doing it in kernel.

Thanks
Vivek
