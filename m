Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293546AbSCPAF3>; Fri, 15 Mar 2002 19:05:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293548AbSCPAEV>; Fri, 15 Mar 2002 19:04:21 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:23730 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S293549AbSCPADo>; Fri, 15 Mar 2002 19:03:44 -0500
Date: Fri, 15 Mar 2002 16:02:28 -0800
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: "Randy.Dunlap" <rddunlap@osdl.org>, John Helms <john.helms@photomask.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
        Trice Jim <Jim.Trice@photomask.com>
Subject: Re: bug (trouble?) report on high mem support
Message-ID: <21660000.1016236948@flay>
In-Reply-To: <Pine.LNX.4.33L2.0203151526250.14689-200000@dragon.pdx.osdl.net>
In-Reply-To: <Pine.LNX.4.33L2.0203151526250.14689-200000@dragon.pdx.osdl.net>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From how I read his original description:

> 2.  A program we use runs almost entirely in kernel 
> mode in a kernel compiled for large (>4GB) memory support.
> Same program runs in user mode in a kernel only compiled
> for smp support (4GB memory limit).  Top output shows only
> ~5% cpu for user, ~95% for system and program runs VERY slow.
> SMP kernel has ~60% user, ~40% system and program runs
> acceptably.

I assumed the problem occured when he switched from 4Gb support
to 64Gb support ... am I just misreading this? So he should already
be bouncing everything with 4Gb (which seems to work) around 
unless he has the high io stuff.

The only thing that looked wierd in his profile was this:

54729 do_mmap_pgoff                             51.8267

John, can you try "echo 2 > /proc/profile" just before you run your
test, and then readprofile immediately your test stops? That'll zero
the profile just before you start, and should make the output a little
more "focused", and confirm that this function is what's eating the
sys time.

M.

--On Friday, March 15, 2002 15:38:11 -0800 "Randy.Dunlap" <rddunlap@osdl.org> wrote:

> Hi-
> 
> If someone (Martin or Alan ?) hasn't already told you,
> there is a block-highmem patch for 2.4.teens, so if you
> can upgrade your kernel to 2.4.19-pre3, for example,
> the block-highmem patch is at
>   http://www.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.19pre3aa2/
> file: 00_block-highmem-all-18b-7.gz
> 
> Also, as suggested a day or two ago, you could profile the
> kernel to see where it is spending time, although I'm not
> sure how useful that would be.
> 
> A third alternative for you is to apply the attached patch.
> I applied it to 2.4.9 (it applies with a little "fuzz"),
> but I haven't tested it on 2.4.9, just 2.4.teens.
> 
> It counts bounce IOs, both normal IOs and swap IOs.
> They can be displayed by printing /proc/stats .
> This patch doesn't work with the block-highmem
> patch applied -- I'm working on a different patch for that.
> 
> This patch also prints (by major:minor) which device(s) are
> causing bounce IO.  This printing could become excessive
> for you, so don't hesitate to disable it (comment it out, or
> let me know if you need help with it).
> 
> Regards,
> ~Randy
> 
> 
> On Fri, 15 Mar 2002, John Helms wrote:
> 
>| Alan,
>| 
>| Ok, how do I go about determining that?  The machine
>| I have is a brand-spankin' new IBM x-series 350 with
>| 4 900MHz Xeon processors.  The system bios can
>| recognize all of the 16320MB of memory at startup.
>| If those patches work, it will save our butts as
>| we have a major conversion project that hinges on
>| this.
>| 
>| Thanks,
>| jwh
>| 
>| >>>>>>>>>>>>>>>>>> Original Message <<<<<<<<<<<<<<<<<<
>| 
>| On 3/15/02, 2:30:22 PM, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote regarding
>| Re: bug (trouble?) report on high mem support:
>| 
>| 
>| > > Here is a top output.  We have 16Gb of ram.
>| > > I have also tried a 2.4.9-31 enterprise=20
>| > > kernel rpm from RedHat with the same=20
>| > > results.
>| 
>| > Ok that would make sense. Next question is do you have an I/O controller
>| > that can use all the 64bit address space on the PCI bus ?
>| 
>| > What is happening is that you are using a lot of CPU copying buffers down
>| > into lower memory to transfer to/from disk - as well probably as that
>| > causing a lot of competition for low memory. If your I/O controller can
>| hit
>| > the full 64bit space there are some rather nice test patches that should
>| > completely obliterate the problem.
>| 
>| > Alan


