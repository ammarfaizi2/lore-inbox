Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283489AbRLIV1V>; Sun, 9 Dec 2001 16:27:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284440AbRLIV1M>; Sun, 9 Dec 2001 16:27:12 -0500
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:38292 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S283489AbRLIV07>; Sun, 9 Dec 2001 16:26:59 -0500
Date: Sun, 9 Dec 2001 14:26:35 -0700
Message-Id: <200112092126.fB9LQZE12582@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Roman Zippel <zippel@linux-m68k.org>, Rene Rebe <rene.rebe@gmx.net>,
        linux-kernel@vger.kernel.org, alsa-devel@lists.sourceforge.net
Subject: Re: devfs unable to handle permission: 2.4.17-pre[4,5] 
 /ALSA-0.9.0beta[9,10]
In-Reply-To: <Pine.LNX.4.21.0112091744430.24350-100000@freak.distro.conectiva>
In-Reply-To: <3C1378D6.A5BAB1FA@linux-m68k.org>
	<Pine.LNX.4.21.0112091744430.24350-100000@freak.distro.conectiva>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti writes:
> 
> 
> On Sun, 9 Dec 2001, Roman Zippel wrote:
> 
> > Richard Gooch wrote:
> > 
> > > Oh, the "tar kludge". That script has been obsolete for over a year
> > > and a half. I should have removed it ages ago. I really should get
> > > around to doing that one day.
> > 
> > You should have done this a year ago. Permission management with the
> > "tar kludge" was a valid option so far and is currently in use. There
> > was no warning period that this future would be obsolete.
> > BTW from your devfsd-v1.3.20 release notes:
> > 
> > "NOTE: this release finally provides complete permissions management.
> > Manually (i.e. non driver or devfsd) created inodes can now be
> > restored when devfsd starts up. This requires v1.2 of the devfs core
> > (available in 2.4.17-pre1) for best operation."
> > 
> > The tar solution only works until 2.4.16, the new devfsd provides this
> > only with 2.4.17. I'll leave the final decision to Marcelo, whether he
> > accepts this or not. I shut up now, may someone else explain the meaning
> > of compatibility to you.
> 
> Roman, 
> 
> I haven't read the whole thread.
> 
> Could you please explain me what is the problem in detail? 

I can explain it. The old devfs core was forgiving of duplicate
entries, while the new one is not (it now gives EEXIST errors).

There are some broken boot scripts (modelled after the long obsolete
rc.devfs script) which dump a whole bunch of inodes in /dev, prior to
loading various modules. So the drivers which load after this will not
be able to create their devfs entries (because said entries already
exist).

This is not actually a problem for leaf nodes, since the user-space
created device nodes will still work. It just results in a warning
message. It is potentially a problem for directories, if the following
conditions are all met:
- boot scripts create a directory in /dev
- driver loads and tries to create same directory (fails)
- driver creates device nodes under that directory using the handle it
  obtained from creating the directory
- device nodes driver is trying to create were not created by boot
  script (i.e. the untar process).

This is a fairly rare case. Usually, if you are "restoring" some
inodes, you will be restoring the individual device nodes as well as
the parent directory (otherwise, what's the point of restoring?).
So, in this case, the device nodes that the user wants to use will
still be there (created by the boot script) and will work fine. There
will just be a bunch of warning messages.
Possibly, depending on the driver, the device nodes it tried to create
may appear in the /dev directory, rather than the intended
subdirectory. While perhaps messy, this isn't actually harmful.

This thread was spawned because of a bug report with two issues. The
first issue was the harmless warning messages about duplicate leaf
node entries. Nothing broke.
The second issue was due to a broken devfsd configuration file which
caused the wrong permissions to be set on a directory. This led to
Roman thinking that the new devfs core was breaking stuff. As I've
shown above, the breakage is a rare corner case involving an obsolete
script.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
