Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312997AbSDBXjH>; Tue, 2 Apr 2002 18:39:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312994AbSDBXi6>; Tue, 2 Apr 2002 18:38:58 -0500
Received: from london.rubylane.com ([208.184.113.40]:15130 "HELO
	london.rubylane.com") by vger.kernel.org with SMTP
	id <S312996AbSDBXir>; Tue, 2 Apr 2002 18:38:47 -0500
Message-ID: <20020402233842.25600.qmail@london.rubylane.com>
From: jim@rubylane.com
Subject: Update on Promise 100TX2 + Serverworks IDE issues -- 2.2.20
To: andre@linux-ide.org
Date: Tue, 2 Apr 2002 15:38:41 -0800 (PST)
Cc: linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

FYI, here's an IDE update.  I'm probably going to post a note on the
kernel mailing list about this to maybe help someone else avoid a
nasty problem, or maybe someone will have an "Ah Ha!" moment.

1. Linux 2.2.19 (and .20) + the Serverworks IDE chipset on the
Supermicro P3DLE is definitely hosed.  Copying files from hda to hdc
causes both hda and hdc to be corrupted.  I even took out the Promise
cards altogether to make sure there wasn't some interaction going on
there.  I don't think your patches have anything to do with this
because it broke before without your patches, and also breaks with
your patches.

2. The MB IDE ports transfer data at about 18000K/sec while doing
cat /dev/hda >/dev/null and looking at vmstat.

3. The Promise card does about 31300K/sec doing the same thing.

4. If 2 Promise cards are installed and each of 4 Maxtor 5T060H6
drives get their own IDE port (ide2-5), the drives are hde, hdg, hdi,
hdk.  In a 32-bit slot, cat /dev/hdx >/dev/null shows 31300K/sec.  But
doing cat /dev/hde4 (a specific partition) for example gives
8400K/sec.  That makes no sense to me.

5. If 1 Promise card has a drive installed as slave on the second
port, that drive will causes CRC errors on the console.  I didn't try
slaving on the first port - it may be broken too.  Switching drives
doesn't make this problem go away, and drives that generate errors
work perfectly as master.  Setting drives to master/slave or using
cable select doesn't affect the problem.

6. If the Promise card is installed in one of the two 64-bit/66MHz
slots on the Supermicro MB, then hde (the first ide port) behaves the
same: 31300K/sec if catting /dev/hde, but only 8400K/sec if catting
/dev/hde4.  HOWEVER, the master drive on the second port, hdg, yields
31300K/sec for both cat /dev/hdg and cat /dev/hdg4.  I have swapped
drives around and verified this on combinations of drives and
controllers.  I know it doesn't make sense, but thought I'd report it
in case there is something flakey in the ide driver.  Maybe burst mode
is only getting used for this one port or something??

I dunno.  This is all getting way too confusing so I am going to find
a configuration that works and stop trying to make it work perfectly
and understand the ins and outs.

My current config is:
  hda = MB ide port 0 master
  hdg = Promise #1 port 1 master
  hde = Promise #1 port 0 master
  hdk = Promise #2 port 1 master

All the drives on the Promise boards are running at 31300K now, even
hde (which again, I don't understand).  hda+hdg will be a RAID1 pair,
hde+hdk will be a RAID1 pair.  Seems to be working - I give up 
understanding it.

Appreciate all your IDE efforts, and after this recent nosebleed, I 
have much more empathy about how much of a pain this all must be for
you sometimes. :)

Jim Wilcoxson
Owner, www.rubylane.com

(I'm not on the kernel mailing list but comments/suggestions via email
are welcome.)
