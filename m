Return-Path: <linux-kernel-owner+w=401wt.eu-S1753493AbWLRIKU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753493AbWLRIKU (ORCPT <rfc822;w@1wt.eu>);
	Mon, 18 Dec 2006 03:10:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753495AbWLRIKU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Dec 2006 03:10:20 -0500
Received: from mail9.hitachi.co.jp ([133.145.228.44]:58333 "EHLO
	mail9.hitachi.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753493AbWLRIKS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Dec 2006 03:10:18 -0500
Message-ID: <45864C94.5070406@hitachi.com>
Date: Mon, 18 Dec 2006 17:08:52 +0900
From: "Kawai, Hidehiro" <hidehiro.kawai.ez@hitachi.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; ja-JP; rv:1.4) 
    Gecko/20030624 Netscape/7.1 (ax)
X-Accept-Language: ja
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, gregkh@suse.de, james.bottomley@steeleye.com,
       Satoshi OSHIMA <soshima@redhat.com>,
       "Hideo AOKI@redhat" <haoki@redhat.com>,
       sugita <yumiko.sugita.yf@hitachi.com>,
       Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] binfmt_elf: core dump masking support
References: <457FA840.5000107@hitachi.com> 
    <20061213132358.ddcaaaf4.akpm@osdl.org>
In-Reply-To: <20061213132358.ddcaaaf4.akpm@osdl.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Andrew,

Thank you for your reply and advice.
I'll send the revised patchset after I fix what you pointed out.

Andrew Morton wrote:
 
> Regarding the implementation: if we add
> 
> 	unsigned char coredump_omit_anon_memory:1;
> 
> into the mm_struct right next to `dumpable' then we avoid increasing the
> size of the mm_struct, and the code gets neater.
> 
> Modification of this field is racy, and we don't have a suitable lock in
> mm_struct to fix that.  I don't think we care about that a lot, but it'd be
> best to find some way of fixing it.

OK, I'll put a bit field right next to `dumpable' member and add a global
lock to protect them from the race.
I have the perception that only writing to these bit-fields needs to
acquire a lock. Simultaneous writes to both bit-fields can cause either one
to be overwritten with its old value. But simultaneous read and write
from/to separate bit-fields is safe because write to one bit-field
doesn't affect read from the other.

The dumpable can be modified at following timing:

  - before starting core dumping in do_coredump()
  - when initialize mm_struct in flush_old_exec()
  - when *uid or *gid is changed by the coresponding system call
  - when the dumpable is modified directly by prctl(2)

I expect that these don't occur so much frequently, so I consider that
the performance impact by using a global lock is small.


> Really we should convert binfmt_aout.c and any other coredumpers too.

Currently, binfmt_aout.c and binfmt_elf_fdpic.c have their own core dump
routines as well as binfmt_elf.c.  However, as far as I know,
binfmt_aout.c never dumps shared memory. 
So I will convert only binfmt_elf_fdpic.c to support this feature.

 
> Does this feature have any security implications?  For example, there might
> be system administration programs which force a coredump on a "bad"
> process, and leave the core somewhere for the administrator to look at. 
> With this change, we permit hiding of that corefile's anon memory from the
> administrator.  OK, lame example, but perhaps there are better ones.

I think we can avoid it by providing a sysctl parameter which
disables/enables this feature.

Another idea is that we provide a sysctl parameter to prohibit non-root
user from writing to /proc/<pid>/coremask. If the administrator want to 
force a full coredump on a bad process, he/she only has to clear the
coremask after setting the sysctl parameter.

For now, I will implement the first idea, because its design and
implementation are simple and it is easy to use.

Best regards,

-- 
Hidehiro Kawai
Hitachi, Ltd., Systems Development Laboratory


