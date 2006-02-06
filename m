Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932262AbWBFRnz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932262AbWBFRnz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 12:43:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932244AbWBFRnz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 12:43:55 -0500
Received: from mail-in-08.arcor-online.net ([151.189.21.48]:8085 "EHLO
	mail-in-08.arcor-online.net") by vger.kernel.org with ESMTP
	id S932262AbWBFRny convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 12:43:54 -0500
Date: Mon, 6 Feb 2006 18:43:43 +0100 (CET)
From: Bodo Eggert <7eggert@gmx.de>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
cc: matthias.andree@gmx.de, mrmacman_g4@mac.com, mj@ucw.cz,
       linux-kernel@vger.kernel.org, jengelh@linux01.gwdg.de,
       James@superbug.co.uk, j@bitron.ch, acahalan@gmail.com, 7eggert@gmx.de
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
In-Reply-To: <43E76163.nail7GN513UL9@burner>
Message-ID: <Pine.LNX.4.58.0602061658220.2231@be1.lrz>
References: <5zer2-1BC-29@gated-at.bofh.it> <5AFHY-5jd-23@gated-at.bofh.it>
 <5ALb5-5kV-43@gated-at.bofh.it> <5B15G-39W-17@gated-at.bofh.it>
 <5B1Im-4cW-7@gated-at.bofh.it> <5B3TN-7AV-9@gated-at.bofh.it>
 <5Bs5Z-1BT-17@gated-at.bofh.it> <5BJgx-1fE-13@gated-at.bofh.it>
 <E1F4nt5-00014L-Ry@be1.lrz> <43E36084.nail5CAJ14LO3@burner>
 <20060203193056.GD18533@merlin.emma.line.org> <43E76163.nail7GN513UL9@burner>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-be10.7eggert.dyndns.org-MailScanner-Information: See www.mailscanner.info for information
X-be10.7eggert.dyndns.org-MailScanner: Found to be clean
X-be10.7eggert.dyndns.org-MailScanner-From: 7eggert@web.de
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Feb 2006, Joerg Schilling wrote:
> Matthias Andree <matthias.andree@gmx.de> wrote:
> > Joerg Schilling schrieb am 2006-02-03:

> > > This is a limitation of the implementation used on Linux and not true for e.g. 
> > > Solaris.
> >
> > Linux is not Solaris.
> >
> > Do you want your application to work with Linux,
> > because it brings customers?
> >
> > If yes, listen to kernel developers if they say "you don't need that
> > feature". Note I do not consider myself kernel developer. I'm a
> > bystander who's trying to help out.
> 
> ????
> 
> Kernel developers should listen to the right application developers
> (in special when they may have more kernel skills) to find out
> what's needed.

>From what I read, you need a way to map a short ID (possibly formed like 
\mathbb{N}^4) to a (devicename, ID')-tupel, where ID' may be ID, a dummy 
value or something completely different.


With the old /dev/sg-scheme, you had a hard time assigning 
/dev/sg_num_of_the_day to a device, and you had to enqure each for the ID 
in order to at least give a stable name. Obviously this was bad, therefore 
it was superseded by the current method, making /dev/sg obsolete. It is 
still supported, but nobody will enheance it to include IDE.


With the current mechanism, you can assign a user-defined name like
/dev/scsi/host1/bus2/id3/lun4/cd, /dev/scsi/1.2.3.4, /dev/bjørn or
/dev/cdr/vendor_model. Obviously some are hard to type, and some are 
designed to be typed by the user. In the later case, the user should be 
allowed to use these names even if it isn't portable, and in the 
former cases, having a nice thing.

For systems using /dev/scsi/1.2.3.4 etc., you can enumerate all devices by
walking a list of paths and trying each device in turn, and you can find
the device node using a regular expression.

On systems using /dev/cdr/vendor_model or /dev/bjørn, you can't list all 
devices yourself, but maybe you can exec a user-defined program doing this 
work for you. In order to find the device again, you can either make the  
list be (device node, ID), or define a reverse switch giving you just the 
device node. I'd prefer the later, since that'd let you handle device 
names containing spaces.

I'd use a script for both cases, and since many systems will use the 
numeric scheme, maybe provide a default script for them. If the user or 
the distribution doesn't use numeric IDs, they can create their own 
script. (Off cause you'll still need the sg-scanning for 2.4 kernels).


Example for my system, obviously slightly untested:

---/etc/default/cdrecord:---
#aliases
toshiba TOSHIBA_XM-6201TA -1 -1
liteon  LITE-ON_LTR-48246K 40 16m
apple   MATSHITA_CR-8004 -1 -1

CDR_DEVICE      = LITE-ON_LTR-48246K
enumerate_devices_bin = /usr/lib/cdrecord-scandevices.sh
---

---/usr/lib/cdrecord-scandevices.sh---
#!/bin/sh
if [ "$1" == "-r" ]; then # reverse mapping
	exec /usr/bin/find /dev/cd{,r} -follow -name "$2"
else
	exec /usr/bin/find /dev/cd{,r} -follow -type b -printf "%f\n"
fi
---

---default script---
#!/bin/sh

if [ "$1" == "-r" ]; then # reverse mapping
	case "$2" in
	-1.* )  a="`echo "$2"|sed -e \
's,\(.*\)\.\(.*\)\.\(.*\)\.\(.*\),.*[^0-9]\2[^0-9]+\3[^0-9]*,'`"
		/usr/bin/find /dev/ide/ -regex "$a" -type b
	;;
	*)      a="`echo "$2"|sed -e \
's,\(.*\)\.\(.*\)\.\(.*\)\.\(.*\),.*[^0-9]\1[^0-9]+\2[^0-9]+\3[^0-9]+\4[^0-9]*,'`"
		/usr/bin/find /dev/scsi/ -regex "$a" -type b
	;;
	esac
else
	/usr/bin/find /dev/ide/ -type b \! -regex '.*part[0-9]+' \
	| sed -e \
's/[^0-9]/./g;s/\.\.*/\./g;s/^\.*//;s/\.*$//;s/^/-1./;s/$/.0/'

	/usr/bin/find /dev/scsi/ \! -regex '.*part[0-9]+' -type b \
	| sed -e 's/[^0-9]/./g;s/\.\.*/\./g;s/^\.*//;s/\.*$//'
fi
---

-- 
One enemy soldier is never enough, but two is entirely too many. 
