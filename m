Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129170AbRBLCfy>; Sun, 11 Feb 2001 21:35:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129609AbRBLCfq>; Sun, 11 Feb 2001 21:35:46 -0500
Received: from ip165-230.fli-ykh.psinet.ne.jp ([210.129.165.230]:26307 "EHLO
	standard.erephon") by vger.kernel.org with ESMTP id <S129267AbRBLCfh>;
	Sun, 11 Feb 2001 21:35:37 -0500
Message-ID: <3A874BE2.51C58711@yk.rim.or.jp>
Date: Mon, 12 Feb 2001 11:35:14 +0900
From: Ishikawa <ishikawa@yk.rim.or.jp>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.1 i686)
X-Accept-Language: ja, en
MIME-Version: 1.0
To: Douglas Gilbert <dougg@torque.net>
CC: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        rgooch@atnf.csiro.au
Subject: Re: devfs: "cd" device not showing up initially. [Fwd: Scan past lun 7 
 in
In-Reply-To: <3A8595DC.B33CB0B2@torque.net>
Content-Type: multipart/mixed;
 boundary="------------14879E8CEFEA7F09FAA7D562"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------14879E8CEFEA7F09FAA7D562
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit

>
>
> > I consider the possibility of module loading. Both SCSI CD and
> > SCSI generic (sg) are modules now.
> > I checked /etc/devfs/devfs.conf (experimental Debian package
> > puts the config file here! ) has the following line:
> >
> >    LOOKUP  .*              MODLOAD
> >
> > So the module autoloading ought to work. ("generic" exists
> > somehow from the start.)
>
> Chiaki,
> The upper level scsi drivers (sd, sr, st, osst and sg) register
> and unregister device names with devfs. After the mid level
> recognizes a new scsi device it calls the detect() function
> in the builtin upper level drivers and those that are currently
> loaded as modules. That is your "problem", sr_mod.o is not
> loaded until you do something like "ls -l /dev/sr0" (due to
> that LOOKUP rule in /etc/devfsd.conf). The lsmod command will
> show which modules are loaded (in your case look for sr_mod).
>
> There is no "push" mechanism in the scsi mid level to load
> the sr_mod.o module when it sees a device with SCSI type
> CDROM. Devfs (specifically devfsd) supplies various "pull"
> mechanisms (e.g. LOOKUP) to load that module.
>

Doug,

Thank you for enlightening me on the subtle
interaction of module loading and devfs.

One thing that confused me was that "generic" was
present On my system, I use the module version of
scsi generic driver.
Am I right then assuming  that SCSI subsystem
somehow supports the loading of "sg" driver module
automagically (as opposed to mod_sr.o )?
Otherwise I can't explain why "generic" was already
present when I ran "ls", but "cd" wasn't.
(During the boot I see the string "sg" just prior to the
loading of tmscsim (DC390) driver module. The NCR driver
is built-in and recognized earlier. Aha, could it be that
"sg" is used for the initial probing of
device types and such?)
Maybe I am missing something here regarding module
loading very much.

Also, my setting may be quite Debian GNU/Linux
specific.

Anyway, I looked again very carefully at the devfs README file
under

    /usr/src/linux/Documenation/filesystems/devfs

and found it a litte out of date.

 -   Richard Booch has a document
     dated Oct 16, 2000 at the URL site mentioned in the
     README file.

     The one under /usr/src/linux/Documentation/filesystems/devfs
     is dated 3-JUL-2000.

     So at least, we might want to upgrade the document
     to the latest available from the original author.

 -   Yet, even the one at the URL site doesn't
     reflect the name changes that took place last year.
     SCSI device names and others are not quite up to date and
     don't agree with what we see on the real system.
     (I am assuming that this is generally true and
      not Debian-specific.)

Attached is my first cut to update the of the document.
I would appreciate it if the README document is updated
to reflect the current implemntation.
I would be glad to help by typing the first rough draft
initially according to the suggestions.

Happy Hacking,

Chiaki Ishikawa



--------------14879E8CEFEA7F09FAA7D562
Content-Type: text/plain; charset=iso-8859-15;
 name="README.devfs.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="README.devfs.diff"

*** /usr/src/linux/Documentation/filesystems/devfs/README	Thu Nov 30 03:11:38 2000
--- README.devfs	Mon Feb 12 11:15:29 2001
***************
*** 444,447 ****
--- 444,460 ----
  openings.
  
+ [In the current implementation as of Feb 2001, 
+ all the existing CD-ROM drives
+ appear under /dev/cdroms as cdrom0, cdrom1, ..., etc.
+ with appropriate symlinks pointing to the real CD device as in the following
+ snippet.
+ 
+ lr-xr-xr-x    1 root     root           34 Jan  1  1970 cdrom0 -> ../scsi/host1/bus0/target5/lun1/cd
+ lr-xr-xr-x    1 root     root           34 Jan  1  1970 cdrom1 -> ../scsi/host1/bus0/target6/lun0/cd
+ lr-xr-xr-x    1 root     root           34 Jan  1  1970 cdrom2 -> ../scsi/host1/bus0/target6/lun1/cd
+ 
+ There is no /dev/sr. ]
+ 
+ 
  -----------------------------------------------------------------------------
  
***************
*** 1035,1039 ****
  	cd
  
- 
  The SCSI generic driver creates:
  
--- 1048,1051 ----
***************
*** 1132,1135 ****
--- 1144,1161 ----
  
  
+ [The current implemenation as of Feb 2001 uses the following scheme?
+ 
+ All the discs including IDE are put under
+ 	/dev/discs/
+ 		disc0, disc1, disc2, ...
+ 
+ 	All the entries are symlinks to the real device names under /dev/ide,
+ 	/dev/scsi, etc.. 
+ 	eg. 
+   		disc0 -> ../ide/host0/bus0/target0/lun0
+                 disc1 -> ../scsi/host0/bus0/target4/lun0
+ 	        disc2 -> ../scsi/host1/bus0/target5/lun0
+  ]
+ 
  SCSI Tapes
  
***************
*** 1148,1151 ****
--- 1174,1181 ----
  
  
+ [The current implemenation as of Feb 2001 uses the following scheme?
+ 	Insert the current usage . ]
+ 
+ 
  SCSI CD-ROMs
  
***************
*** 1156,1161 ****
--- 1186,1226 ----
  	/dev/sr/c1b2t3u4
  
+ [The above should be completely rewritten. ]
+ The current implemenation as of Feb 2001 uses the following scheme?
+ 	
+ 	All the CD-ROMs including the SCSI CD-ROMs are put under
+ 	/dev/cdrom
+ 
+ 	cdrom0 -> ../scsi/host1/bus0/target5/lun1/cd
+ 	cdrom1 -> ../scsi/host1/bus0/target6/lun0/cd
+ 	cdrom2 -> ../scsi/host1/bus0/target6/lun1/cd
+ 
+ There is no /dev/sr. ]
+ 
+ 
  
  SCSI Generic Devices
+ 
+ [CI's comment: There is something wrong with the following
+  paragraph. There is no /dev/sg to begin with.
+  Shouldn't the original sentence ought to read
+  "All SCSI generic devices are placed ..."?
+  We can probably simply state that
+  SCSI generic devices appear under the
+  device directory of the form
+ 	/dev/scsi/hostC/busB/targetT/lunU/
+ 
+ 
+ 	Eg. C=1, B=0, T=6, U=2
+ 
+   /dev/scsi/host1/bus0/target6/lun2:
+   sum 0
+   drwxr-xr-x    1 root     root            0 Jan  1  1970 .
+   drwxr-xr-x    1 root     root            0 Jan  1  1970 ..
+   brw-rw----    1 root     cdrom     11,   3 Jan  1  1970 cd
+   crw-------    1 root     root      21,   5 Jan  1  1970 generic
+ 
+  ]
+ 
  
  All SCSI CD-ROMs are placed under /dev/sg. A similar naming

--------------14879E8CEFEA7F09FAA7D562--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
