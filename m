Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S135399AbQK0Cub>; Sun, 26 Nov 2000 21:50:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S135390AbQK0CuU>; Sun, 26 Nov 2000 21:50:20 -0500
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.29]:25095 "HELO
        note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
        id <S135358AbQK0CuL>; Sun, 26 Nov 2000 21:50:11 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Friedrich Lobenstock <fl@fl.priv.at>
Date: Mon, 27 Nov 2000 13:18:52 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14881.50316.705469.752219@notabene.cse.unsw.edu.au>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kbuild@torque.net,
        linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org
Subject: Re: [BUG] 2.4.0-test11-ac3 breaks raid autodetect (was Re: [BUG] raid5 link 
 error? (was [PATCH] raid5 fix after xor.c cleanup))
In-Reply-To: message from Friedrich Lobenstock on Sunday November 26
In-Reply-To: <20001117234144.A14461@spaans.ds9a.nl>
        <20001118123536.A5674@spaans.ds9a.nl>
        <20001118235352.D2226@spaans.ds9a.nl>
        <14872.29479.901021.472890@notabene.cse.unsw.edu.au>
        <3A2074CC.8219AB99@fl.priv.at>
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
        LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
        8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday November 26, fl@fl.priv.at wrote:
> Neil Brown wrote:
> >
> > The following patch changes the link order in the Makefile so that xor
> > is initiailised before md tries to autostart anything.
> > It also takes the theme a bit further and uses module_init/module_exit
> > to init and shutdown the raid personalities.  This allows us to remove
> > the explicit calls to raidXX_init from md.c, which is nice.
> > 
> > I have tested this patch both
> >    1/ monolithic kernel and autodetecting an array
> >    2/ md and all personalities modules
> > 
> > and it works fine.
> 
> Sorry to tell you that I just tried linux-2.4.0-test11-ac3 (which has this
> patch) and I couldn't boot because the kernel detects the raid1 devices
> but kicks the shortly after. I had to back out this code.

Thanks for this....

I have looked more deeply, and discovered the error of my ways.
As the Makefiles now stand, all export-objs (OX_OBJS) get linked
before non-export-objs (O_OBJS) in the same directory, independantly
of any ordering imposed within the Makefile.
This caused md.o to get linked before raid?.o.
Due to carelessness on my part I didn't notice this happening when I
was testing.

The following patch fixes it.  I hope the change to Rules.make is
acceptable - I have CCed to linux-kbuild incase anyone there has an
issue with it.

Even allowing for that though, some of the boot-time messages look
very strange.  Friedrich: could you let me know how the various
partitions were expected to be combined into raid arrays - from the
boot log, it looks like there are three single drive raid1 arrays, and
that doesn't seem to make much sense.

NeilBrown

--- ./drivers/md/Makefile	2000/11/27 02:05:52	1.1
+++ ./drivers/md/Makefile	2000/11/27 02:09:42	1.2
@@ -28,6 +28,9 @@
 # Translate to Rules.make lists.
 O_OBJS		:= $(filter-out $(export-objs), $(obj-y))
 OX_OBJS		:= $(filter     $(export-objs), $(obj-y))
+# Need to maintain ordering between O_ and OX_ objects, so define ALL_O our selves
+ALL_O		:= $(obj-y)
+
 M_OBJS		:= $(sort $(filter-out $(export-objs), $(obj-m)))
 MX_OBJS		:= $(sort $(filter      $(export-objs), $(obj-m)))
 
--- ./Rules.make	2000/11/27 02:08:52	1.1
+++ ./Rules.make	2000/11/27 02:09:42	1.2
@@ -85,7 +85,9 @@
 # Rule to compile a set of .o files into one .o file
 #
 ifdef O_TARGET
+ifndef ALL_O
 ALL_O = $(OX_OBJS) $(O_OBJS)
+endif # ALL_O
 $(O_TARGET): $(ALL_O)
 	rm -f $@
     ifneq "$(strip $(ALL_O))" ""
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
