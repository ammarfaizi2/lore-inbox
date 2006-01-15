Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932114AbWAOTsV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932114AbWAOTsV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jan 2006 14:48:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932116AbWAOTsV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jan 2006 14:48:21 -0500
Received: from flock1.newmail.ru ([212.48.140.157]:43724 "HELO
	flock1.newmail.ru") by vger.kernel.org with SMTP id S932114AbWAOTsU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jan 2006 14:48:20 -0500
From: Andrey Borzenkov <arvidjaar@newmail.ru>
To: Jean Delvare <khali@linux-fr.org>
Subject: Re: [lm-sensors] 2.6.15: lm90 0-004c: Register 0x13 read failed (-1)
Date: Sun, 15 Jan 2006 22:48:06 +0300
User-Agent: KMail/1.9.1
Cc: lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org
References: <200601142223.35838.arvidjaar@newmail.ru> <200601150045.30942.arvidjaar@newmail.ru> <200601152212.31491.arvidjaar@newmail.ru>
In-Reply-To: <200601152212.31491.arvidjaar@newmail.ru>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601152248.07800.arvidjaar@newmail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Sunday 15 January 2006 22:12, Andrey Borzenkov wrote:
> On Sunday 15 January 2006 00:45, Andrey Borzenkov wrote:
> > On Sunday 15 January 2006 00:20, Jean Delvare wrote:
> > > Hi Andrey,
> > >
> > > > Vanilla 2.6.15 on Toshiba Portege 4000. I get constant messages in
> > > > dmesg:
> > > >
> > > > i2c_adapter i2c-0: Error: command never completed
> > > > lm90 0-004c: Register 0x1 read failed (-1)
> > > > i2c_adapter i2c-0: Error: command never completed
> > > > lm90 0-004c: Register 0x14 read failed (-1)
> > > > i2c_adapter i2c-0: Error: command never completed
> > > > lm90 0-004c: Register 0x8 read failed (-1)
> > > > i2c_adapter i2c-0: Error: command never completed
> > > > lm90 0-004c: Register 0x0 read failed (-1)
> > > >
> > > > for quite a number of registers. Apparently I can read sensors just
> > > > fine still I am uneasy seeing those.
> > >
> > > Before 2.6.15, the lm90 driver did not handle read errors in any way,
> > > so they were probably already there, you simply were not aware of it.
> > > However, I guess that you already had the "command never completed"
> > > errors? These come from the i2c-ali1535 bus driver.
> >
> > Before 2.6.15 I run Mandriva kernel 2.6.12-12mdk. I do not remember them
> > but may be I just never actually looked in dmesg :)
> >
> > > It would be possible to add a retry-on-failure mechanism in the lm90
> > > driver. However, the real problem is more likely in the i2c-ali1535
> > > driver so fixing this one driver would be preferable.
> > >
> > > > eeprom-i2c-0-50
> > > > Adapter: SMBus ALI1535 adapter at ef00
> > > > Memory type:            SDR SDRAM DIMM
> > > > Memory size (MB):       256
> > > >
> > > > adm1032-i2c-0-4c
> > > > Adapter: SMBus ALI1535 adapter at ef00
> > > > M/B Temp:    +43°C  (low  =   -65°C, high =  +127°C)
> > > > CPU Temp:  +47.6°C  (low  = +43.0°C, high = +51.0°C)   ALARM
> > > > M/B Crit:   +127°C  (hyst =  +122°C)
> > > > CPU Crit:   +100°C  (hyst =   +95°C)
> > >
> > > Do you also have "command never completed" errors without an associated
> > > error from the lm90 driver?
> >
> > yes, on boot.
> >
> > > This would suggest that the eeprom driver
> > > too is triggering errors, which in turn would confirm that we need to
> > > fix the i2c-ali1535 driver rather than adding a workaround to the lm90
> > > driver.
> > >
> > > It looks like the i2c-ali1535 driver as it exists in the lm_sensors CVS
> > > repository (for Linux 2.4 kernels) did receive a major change in March
> > > 2005. These changes were supposed to "fix stability problems" (by
> > > adding delay loops pretty much everywhere). They were never ported to
> > > the Linux 2.6 version of the driver. Maybe we should try doing so now.
> > >
> > > This is a 400 lines patch, porting it won't be trivial, I am not
> > > familiar with this driver myself and I don't have a chip to test my
> > > changes on, so if someone else wants to take his/her chance, go. If
> > > not, I'll do it.
> > >
> > > Andrey, will you be able to test a i2c-ali1535 patch if we come up with
> > > one?
> >
> > Yes. Send me a patch (or give a link) and I'll try what I can do to port
> > it. I ask if I have a question :)
>
> Do you mean revision 1.21 with date: 2005/03/27 02:22:10;  author: mds? I
> checked and this one seems to be in current 2.6.15.1 kernel. I did not
> check if there were any omissions comparing with CVS but current kernel
> does contain and use ali1535_transaction() added by mentioned patch.
>


I compiled i2c-ali1535 with debugging. I have to types of errors. First block 
is:

Jan 15 22:17:53 cooker kernel: i2c_adapter i2c-0: Transaction (post): STS=14, 
TYP=10, CMD=03, ADD=99, DAT0=00, DAT1=10
Jan 15 22:17:53 cooker kernel: i2c_adapter i2c-0: Transaction (pre): STS=04, 
TYP=00, CMD=03, ADD=9a, DAT0=00, DAT1=10
Jan 15 22:17:53 cooker kernel: i2c_adapter i2c-0: Error: no response or bus 
collision ADD=9a
Jan 15 22:17:53 cooker kernel: i2c_adapter i2c-0: Error: command never 
completed
Jan 15 22:17:53 cooker kernel: i2c_adapter i2c-0: Transaction (post): STS=44, 
TYP=00, CMD=03, ADD=9a, DAT0=00, DAT1=10
Jan 15 22:17:53 cooker kernel: i2c_adapter i2c-0: Transaction (pre): STS=04, 
TYP=00, CMD=03, ADD=a0, DAT0=00, DAT1=10
Jan 15 22:17:53 cooker kernel: i2c_adapter i2c-0: Transaction (post): STS=14, 
TYP=00, CMD=03, ADD=a0, DAT0=00, DAT1=10
Jan 15 22:17:53 cooker kernel: i2c_adapter i2c-0: Transaction (pre): STS=04, 
TYP=00, CMD=03, ADD=a0, DAT0=00, DAT1=10
Jan 15 22:17:53 cooker kernel: i2c_adapter i2c-0: Transaction (post): STS=14, 
TYP=00, CMD=03, ADD=a0, DAT0=00, DAT1=10
Jan 15 22:17:53 cooker kernel: i2c_adapter i2c-0: Transaction (pre): STS=04, 
TYP=00, CMD=03, ADD=a2, DAT0=00, DAT1=10
Jan 15 22:17:53 cooker kernel: i2c_adapter i2c-0: Error: no response or bus 
collision ADD=a2
Jan 15 22:17:53 cooker kernel: i2c_adapter i2c-0: Error: command never 
completed
Jan 15 22:17:53 cooker kernel: i2c_adapter i2c-0: Transaction (post): STS=44, 
TYP=00, CMD=03, ADD=a2, DAT0=00, DAT1=10
Jan 15 22:17:53 cooker kernel: i2c_adapter i2c-0: Transaction (pre): STS=04, 
TYP=00, CMD=03, ADD=a4, DAT0=00, DAT1=10
Jan 15 22:17:53 cooker kernel: i2c_adapter i2c-0: Error: no response or bus 
collision ADD=a4
Jan 15 22:17:53 cooker kernel: i2c_adapter i2c-0: Error: command never 
completed
Jan 15 22:17:53 cooker kernel: i2c_adapter i2c-0: Transaction (post): STS=44, 
TYP=00, CMD=03, ADD=a4, DAT0=00, DAT1=10
Jan 15 22:17:53 cooker kernel: i2c_adapter i2c-0: Transaction (pre): STS=04, 
TYP=00, CMD=03, ADD=a6, DAT0=00, DAT1=10
Jan 15 22:17:53 cooker kernel: i2c_adapter i2c-0: Error: no response or bus 
collision ADD=a6
Jan 15 22:17:53 cooker kernel: i2c_adapter i2c-0: Error: command never 
completed
Jan 15 22:17:53 cooker kernel: i2c_adapter i2c-0: Transaction (post): STS=44, 
TYP=00, CMD=03, ADD=a6, DAT0=00, DAT1=10
Jan 15 22:17:53 cooker kernel: i2c_adapter i2c-0: Transaction (pre): STS=04, 
TYP=00, CMD=03, ADD=a8, DAT0=00, DAT1=10
Jan 15 22:17:53 cooker kernel: i2c_adapter i2c-0: Error: no response or bus 
collision ADD=a8
Jan 15 22:17:53 cooker kernel: i2c_adapter i2c-0: Error: command never 
completed
Jan 15 22:17:53 cooker kernel: i2c_adapter i2c-0: Transaction (post): STS=44, 
TYP=00, CMD=03, ADD=a8, DAT0=00, DAT1=10
Jan 15 22:17:53 cooker kernel: i2c_adapter i2c-0: Transaction (pre): STS=04, 
TYP=00, CMD=03, ADD=aa, DAT0=00, DAT1=10
Jan 15 22:17:53 cooker kernel: i2c_adapter i2c-0: Error: no response or bus 
collision ADD=aa
Jan 15 22:17:53 cooker kernel: i2c_adapter i2c-0: Error: command never 
completed
Jan 15 22:17:53 cooker kernel: i2c_adapter i2c-0: Transaction (post): STS=44, 
TYP=00, CMD=03, ADD=aa, DAT0=00, DAT1=10
Jan 15 22:17:53 cooker kernel: i2c_adapter i2c-0: Transaction (pre): STS=04, 
TYP=00, CMD=03, ADD=ac, DAT0=00, DAT1=10
Jan 15 22:17:53 cooker kernel: i2c_adapter i2c-0: Error: no response or bus 
collision ADD=ac
Jan 15 22:17:53 cooker kernel: i2c_adapter i2c-0: Error: command never 
completed
Jan 15 22:17:53 cooker kernel: i2c_adapter i2c-0: Transaction (post): STS=44, 
TYP=00, CMD=03, ADD=ac, DAT0=00, DAT1=10
Jan 15 22:17:53 cooker kernel: i2c_adapter i2c-0: Transaction (pre): STS=04, 
TYP=00, CMD=03, ADD=ae, DAT0=00, DAT1=10
Jan 15 22:17:53 cooker kernel: i2c_adapter i2c-0: Error: no response or bus 
collision ADD=ae
Jan 15 22:17:53 cooker kernel: i2c_adapter i2c-0: Error: command never 
completed
Jan 15 22:17:53 cooker kernel: i2c_adapter i2c-0: Transaction (post): STS=44, 
TYP=00, CMD=03, ADD=ae, DAT0=00, DAT1=10
Jan 15 22:17:57 cooker kernel: i2c_adapter i2c-0: Transaction (pre): STS=04, 
TYP=10, CMD=00, ADD=98, DAT0=00, DAT1=10
Jan 15 22:17:57 cooker kernel: i2c_adapter i2c-0: Transaction (post): STS=14, 
TYP=10, CMD=00, ADD=98, DAT0=00, DAT1=10

this appears simply a probing for non-existent i2c ports (correct me if I am 
wrong) presumably by eeprom driver.

Second block are errors from lm90 for different registers:

Jan 15 22:24:02 cooker kernel: i2c_adapter i2c-0: Transaction (pre): STS=04, 
TYP=10, CMD=01, ADD=99, DAT0=a0, DAT1=10
Jan 15 22:24:02 cooker kernel: i2c_adapter i2c-0: Transaction (post): STS=14, 
TYP=10, CMD=01, ADD=99, DAT0=29, DAT1=10
Jan 15 22:24:02 cooker kernel: i2c_adapter i2c-0: Transaction (pre): STS=04, 
TYP=10, CMD=08, ADD=98, DAT0=29, DAT1=10
Jan 15 22:24:02 cooker kernel: i2c_adapter i2c-0: Error: command never 
completed
Jan 15 22:24:02 cooker kernel: i2c_adapter i2c-0: Transaction (post): STS=04, 
TYP=10, CMD=08, ADD=98, DAT0=29, DAT1=10
Jan 15 22:24:02 cooker kernel: lm90 0-004c: Register 0x8 read failed (-1)
Jan 15 22:24:02 cooker kernel: i2c_adapter i2c-0: Transaction (pre): STS=04, 
TYP=10, CMD=07, ADD=98, DAT0=29, DAT1=10
Jan 15 22:24:02 cooker kernel: i2c_adapter i2c-0: Transaction (post): STS=14, 
TYP=10, CMD=07, ADD=98, DAT0=29, DAT1=10

Here I do not see SMBus errors - it appears really that i2c device did not 
respond. OTOH interesting is that there is no timeout. Apparently command 
completed without setting DONE bit. As I have zero knowledge about hardware I 
cannot interpret it. Next driver resets SMBus and it works for some time 
again. Judging by comments in source, it apprently signifies hung ali1535, 
not external i2c device (it is using KILL, and "this doesn't seem to clear 
the controller if an external device is hung")

I am ready to test any patch.

- -andrey
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFDyqb3R6LMutpd94wRAkvsAJ4/nD91TVzezwLIIcRzasBMjVbvewCeKxqa
I563XEGbgfGG239rAQZzJ/A=
=E7Yd
-----END PGP SIGNATURE-----
