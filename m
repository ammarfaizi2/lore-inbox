Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932124AbWAJJ3D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932124AbWAJJ3D (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 04:29:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932132AbWAJJ3D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 04:29:03 -0500
Received: from zproxy.gmail.com ([64.233.162.207]:50481 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932124AbWAJJ3C convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 04:29:02 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=tcIK7pIOv0CrNfHUHAdxD9ANgudrTMrN8QlSZ6kkVA+aarAKEOvmsU8EywRGdxVyzjpaHjFMbFZsaVPGC6WcRhUsAo5xn9VaMUcdT4Jja3uZSGe/6hvWOIv3UfecgGgr7OIVBbXnxTgUue49y+diRA5CYbFnYruik40j4GM/Vtw=
Message-ID: <9a8748490601100129h2ce343f5kc9bc22885f01831a@mail.gmail.com>
Date: Tue, 10 Jan 2006 10:29:00 +0100
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Andi Kleen <ak@suse.de>
Subject: Re: Athlon 64 X2 cpuinfo oddities
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200601100336.31677.ak@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <9a8748490601091218m1ff0607h79207cfafe630864@mail.gmail.com>
	 <p73r77gx36u.fsf@verdi.suse.de>
	 <9a8748490601091812x24aefae3oc0c6750c5321c3ab@mail.gmail.com>
	 <200601100336.31677.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/10/06, Andi Kleen <ak@suse.de> wrote:
> On Tuesday 10 January 2006 03:12, Jesper Juhl wrote:
> > On 10 Jan 2006 02:49:13 +0100, Andi Kleen <ak@suse.de> wrote:
> > > Jesper Juhl <jesper.juhl@gmail.com> writes:
> > > >
> > > > Well, first of all you'll notice that the second core shows a
> > > > "physical id" of 127 while the first core shows an id of 0.  Shouldn't
> > > > the second core be id 1, just like the "core id" fields are 0 & 1?
> > >
> > > In theory it could be an uninitialized phys_proc_id (0xff >> 1),
> > > but it could be also the BIOS just setting the local APIC of CPU 1
> > > to 0xff for some reason.
> > >
> > > If you add a printk("PHYSCPU %d %x\n", smp_processor_id(), phys_proc_id[smp_processor_id()])
> > > at the end of arch/x86_64/kernel/setup.c:early_identify_cpu() what does
> > > dmesg | grep PHYSCPU output?
> > >
> > Not a thing since I'm using arch/i386 here (32bit distribution
> > (Slackware), just building a 32bit kernel optimized for K8).
>
> Ah - how legacy.
>
Yeah, but since my distro of choice is 32bit only and I don't much
feel like porting it myself or using an unofficial port (slamd64) I'm
sticking with a 32bit userspace. And as long as userspace is pure
32bit there doesn't seem to be much point in building a 64bit kernel.
And I only have 2GB of RAM, so I don't have a use for the larger 64bit
address space.
I also don't run any apps that do a lot of math on >32bit numbers, so
there's not much gain there either.
I guess I would bennefit from the extra GPR's, but then I would at the
same time loose a bit by all pointers being 64bit - both lose some
disk space due to larger binaries and I'd have increased memory use
and less efficient L1/L2 cache use.

I don't think there would actually be much gain for me in switching to
a 64bit kernel with a 64bit userspace atm.
But if I'm wrong I'd of course love to hear about it :)


> > But, I stuck that printk into identify_cpu() in
> > arch/i386/kernel/cpu/common.c instead, and this is what I get :
> > $ dmesg | grep PHYSCPU
> > [   30.323965] PHYSCPU 0 0
> > [   30.402588] PHYSCPU 1 7f
>
> Hmm it looks like the phys_proc_id initialization is at the wrong
> place in 32bit. early_cpu_detect is only called on the BP, not
> on the AP. early_intel_workaround is also there incorrectly.
> Might be a mismerge - it should be one function below.
>
> The appended patch should help, but it's untested.
>
It does help. Thank you Andi.
Guess this should be merged.

$ dmesg | grep PHYSCPU
[   34.202835] PHYSCPU 0 0
[   34.281459] PHYSCPU 1 0

$ cat /proc/cpuinfo
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 15
model           : 35
model name      : AMD Athlon(tm) 64 X2 Dual Core Processor 4400+
stepping        : 2
cpu MHz         : 2200.150
cache size      : 1024 KB
physical id     : 0
siblings        : 2
core id         : 0
cpu cores       : 2
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de tsc msr pae mce cx8 apic sep mtrr pge mca
cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt
lm 3dnowext 3dnow pni lahf_lm cmp_legacy ts fid vid ttp
bogomips        : 4401.86

processor       : 1
vendor_id       : AuthenticAMD
cpu family      : 15
model           : 35
model name      : AMD Athlon(tm) 64 X2 Dual Core Processor 4400+
stepping        : 2
cpu MHz         : 2200.150
cache size      : 1024 KB
physical id     : 0
siblings        : 2
core id         : 1
cpu cores       : 2
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de tsc msr pae mce cx8 apic sep mtrr pge mca
cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt
lm 3dnowext 3dnow pni lahf_lm cmp_legacy ts fid vid ttp
bogomips        : 4399.53


> >
> > > >
> > > > Second thing I find slightly odd is the lack of "sse3" in the "flags" list.
> > > > I was under the impression that all AMD Athlon 64 X2 CPU's featured SSE3?
> > > > Is it a case of:
> > > >  a) Me being wrong, not all Athlon 64 X2's feature SSE3?
> > > >  b) The CPU actually featuring SSE3 but Linux not taking advantage of it?
> > > >  c) The CPU features SSE3 and it's being utilized, but /proc/cpuinfo
> > > > doesn't show that fact?
> > > >  d) Something else?
> > >
> > > It's called pni (prescott new instructions) for historical reasons. We added
> > > the bit too early before Intel's marketing department could make up its
> > > mind fully, so Linux is stuck with the old codename.
> > >
> > Does anything actually parse the /proc/cpuinfo flags field? are we
> > really stuck with it?
>
> Do you really want to find out by a report from a rightfully annoyed user?

No, not really. Guess you are right, it could potentially break
userspace to change it now - better not to.

> I considered at some point to print sse3 in addition to pni, but then
> it seemed like too much bloat for only a cosmetical issue. Maybe if it
> becomes a popular FAQ, but it isn't that far yet.
>
Right, it's fine as 'pni' for now.

> (I can just see the headlines for such a patch -
> "Linux 2.6.20 finally adding SSE3 support")
>
Hehe.

> -Andi
>

--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
