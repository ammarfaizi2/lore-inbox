Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317518AbSFRRUq>; Tue, 18 Jun 2002 13:20:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317517AbSFRRUp>; Tue, 18 Jun 2002 13:20:45 -0400
Received: from mail17.speakeasy.net ([216.254.0.217]:2015 "EHLO
	mail.speakeasy.net") by vger.kernel.org with ESMTP
	id <S317512AbSFRRUl>; Tue, 18 Jun 2002 13:20:41 -0400
Subject: Incredible weirdness with eepro100?
From: Joshua Newton <jpnewton@speakeasy.net>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.7-1mdk 
Date: 18 Jun 2002 13:20:40 -0400
Message-Id: <1024420841.2631.14.camel@claymore.corona>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm posting here as a last resort, having spent about forty hours trying
to root out this particular problem. First up, my hardware and software
configuration on the problem machine:

ABIT KT7A-RAID v1.0 w/ 1GHz Athlon Thunderbird
256MB SDR SDRAM
/dev/hda: Maxtor 2B020H1 (20GB, 5400rpm)
/dev/hdc: Maxtor 5T040H4 (40GB, 7200rpm)
/dev/hdd: Sony CDU5211 (52x ATAPI)
eth0: 3Com 3c905B @ 100Mbps/FDX
eth1: Intel PILA8470B (eepro100) @ 100Mbps/FDX

uname -a:

Linux rapier.corona 2.4.19-pre9 #2 Tue Jun 18 11:34:52 EDT 2002 i686
unknown

cat /etc/mandrake-release:

Mandrake Linux release 8.3 (Cooker) for i586


Okay, the problem, as simply as I can state it: uploading really fast to
this particular box works okay for a bit, and then suddenly stops hard.
For example, a quick cp(1) across NFSv3 -- from a known working box to
the whacked-out box -- yields the following:

cp: writing `/scratch/test/chaos12m.sf2': Input/output error

A quick check of dmesg(8) turns up zilch, as does a quick tail on
/var/log/messages. As I'm watching the lights on the switch, they start
off blinking madly, as is proper for a 100Mbps/FDX transmission between
machines connected to the same switch, sitting ~6ft apart, and then the
lights stop blinking entirely.

The behaviour can be repeated across FTP and Samba as well, both with
known-working boxen, one running Linux 2.4.18 stock and the other
running WinXP with all recent patches applied, both using eepro100
cards. Transfer between these two working boxen (only tested via ftp so
far) works beautifully, with the files screaming across at a healthy
~8MB/s.

I am pulling my hair out on this problem. I've tried various different
kernel versions on this box (2.4.19-pre2-ac2, 2.4.18 stock,
2.4.19-pre2), different drivers (in additional to the stock eepro100
drivers, the official Intel e100 driver gives the same results with both
v1.8.37 and v2.0.30), different switch ports (on an Intel Express 520T
Switch -- nice hardware), different NICs (I had a spare eepro100, and
tried that), different protocols, and on and on. I'm just about at the
kicking and screaming stage now.

So far, I've found precisely THREE clues to the problem:

(1) Downloading files is no problem. This ONLY occurs on upload.

(2) The problem is only triggered by certain files being transferred. On
the WinXP box, I was trying to transfer across some .wav files I'd
produced in the course of running some MIDIs thru wavetable synthesis on
the SB Dead! card on the XP box. The first .wav transferred fine, and
every other one stopped dead. This was over FTP, and it was repeatable.
The second time, I was transferring the Chaos 12MB SoundFont bank from
the working Linux 2.4.18 box to the goofy one, and got I/O errors across
NFS. If I copied a bunch of other files first, they'd go across fine,
and then it would choke on the SoundFont. This was repeatable with both
NFS and FTP.

(3) Here's the really good clue: if I transfer the SoundFont bank from
the good box to the goofy box with scp -- hey, it works instantly!

My working guess is that something somewhere in the networking code on
this particular machine -- or in both the e100 and eepro100 drivers --
is seeing SOMETHING it doesn't like in certain files, and it's exploding
on takeoff.

Any assistance whatsoever on this problem would be greatly appreciated.


-- 

"However, Science People like to believe in laws, even when such laws
can be circumvented by their own Science. They become most displeased
if you suggest it would be more accurate to speak of the Generally
Good Idea of Gravity or the Three Useful Guidelines of
Thermodynamics."

		-- James Alan Gardner, /Ascending/

