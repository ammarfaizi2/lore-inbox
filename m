Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262705AbVAVMJi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262705AbVAVMJi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Jan 2005 07:09:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262708AbVAVMJi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Jan 2005 07:09:38 -0500
Received: from pD9F8757A.dip0.t-ipconnect.de ([217.248.117.122]:49282 "EHLO
	susi.maya.org") by vger.kernel.org with ESMTP id S262705AbVAVMJ1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Jan 2005 07:09:27 -0500
From: Andreas Hartmann <andihartmann@01019freenet.de>
X-Newsgroups: fa.linux.kernel
Subject: Re: 2.6.10 dies when X uses PCI radeon 9200 SE, binary search result
Date: Sat, 22 Jan 2005 10:40:52 +0100
Organization: privat
Message-ID: <41F21FA4.1040304@pD9F8757A.dip0.t-ipconnect.de>
References: <fa.ks44mbo.ljgao4@ifi.uio.no> <fa.hinb9iv.s38127@ifi.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Complaints-To: abuse@fu.berlin.de
To: Helge Hafting <helgehaf@aitel.hist.no>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.7.4) Gecko/20050112
X-Accept-Language: de, en-us, en
In-Reply-To: <fa.hinb9iv.s38127@ifi.uio.no>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Helge Hafting schrieb:
> On Fri, Jan 21, 2005 at 09:05:12PM +0100, Andreas Hartmann wrote:
>> Hello Helge,
>> 
>> Helge Hafting schrieb:
>> > On Sun, Jan 16, 2005 at 10:41:23PM +1100, Dave Airlie wrote:
>> >> > 
>> >> > I'm fine with adding this code, but we still don't know if this is the
>> >> > cause of his problem. The debug output can determine if this really is
>> >> > the source of the problem or if it is somewhere else.
>> >> > 
>> >> 
>> >> I actually doubt it is this stuff.. my guess is that it is something
>> >> nasty like ACPI breaking int10 for X or something like that... it
>> >> seems a lot more subtle than the usually things that break when we
>> >> mess with the DRM :-)
>> 
>> Which glibc do you use? I have problems with glibc 2.3.4, kernel 2.4.x and
>> X / Xorg while executing the int10-code of X. glibc 2.3.3 works fine for
>> me. But I could find another posting, which describes, that there are even
>> problems with glibc 2.3.3 and kernel 2.4.x.
>> 
>> It's new for me, that there could be problems with kernelversions of 2.6, too.
>> 
>> Therefore, it would be really interessting to know, which glibc version
>> you are using.
>> 
> I use glibc 2.3.2 from debian testing (or unstable).  
> This is not the problem though, because a reboot into 2.6.8.1 makes
> X work without crashing.  The crash only happens with 2.6.9-rc2
> or later kernels.

Did you try another version of glibc?

> So the only way glibc could be the culprit, is if the newer kernel
> exports some new interface that this glibc manages to mess up.  Still,
> even a buggy glibc shouldn't hang the kernel anyway.

That's certainly correct.

> Such issues
> could crash (all) user apps, but shouldn't prevent the machine from
> responding to sysrq sequences.

You emphasized the differences of the effects. But there is one reason in
all cases which I know: int10 crashes X or even the whole kernel.

I could debug the problem to the following point:

--------------------------------------------------------------------------
static int
vm86_rep(struct vm86_struct *ptr)
{
    int __res;

#ifdef __PIC__
    /* When compiling with -fPIC, we can't use asm constraint "b" because
       %ebx is already taken by gcc. */
    __asm__ __volatile__("pushl %%ebx\n\t"
                         "movl %2,%%ebx\n\t"
                         "movl %1,%%eax\n\t"
                         "int $0x80\n\t"
                         "popl %%ebx"
                         :"=a" (__res)
                         :"n" ((int)113), "r" ((struct vm86_struct *)ptr));
#else
    __asm__ __volatile__("int $0x80\n\t"
                         :"=a" (__res):"a" ((int)113),
                         "b" ((struct vm86_struct *)ptr));
#endif
/* Comment from me */
xf86MsgVerb(X_INFO,3,"my comment\n");
            if (__res < 0) {
                errno = -__res;
                __res = -1;
            }
            else errno = 0;
            return __res;
}

#endif
-----------------------------------------------------------------------

I could see, that X crashes in glibc 2.3.4 with kernel 2.4.x (not with
kernel 2.6.x, x <= 10, x > 10 not tested) during the first malloc syscall
after int10 to execute the function
xf86MsgVerb(X_INFO,3,"my comment\n");


The crashes depend on different versions of used software:

glibc 2.3.3 or 2.3.4 with kernel 2.4.x
glibc 2.3.2 with kernel > 2.6.9rc2

I asked a X developper, but he couldn't help until now, too.


I can't say, if glibc or the kernel could be the problem. You can't relate
it reliable neither to glibc nor to the kernel nor to X. Therefore, it
_seems_ to me, nobody really cares about the problem.

I'm willing to help to find the problem - but I'm neither a kernel
developper, nor a glibc developper nor a X developper. I'm depending on
the support of the developpers.

I think, there should work one developper of each application together to
find the problem. I could ask a X developper, which I know, if he is
willing to help to find the problem together with a developper from the
kernel and from the glibc (I don't know, who to ask from the glibc-team).


Kind regards,
Andreas Hartmann
