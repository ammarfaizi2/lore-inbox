Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264290AbUACWCM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jan 2004 17:02:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264308AbUACWCM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jan 2004 17:02:12 -0500
Received: from sun1000.pwr.wroc.pl ([156.17.1.33]:6645 "EHLO
	sun1000.pwr.wroc.pl") by vger.kernel.org with ESMTP id S264290AbUACWCA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jan 2004 17:02:00 -0500
Date: Sat, 3 Jan 2004 23:01:59 +0100
From: Pawel Dziekonski <pawel.dziekonski@pwr.wroc.pl>
To: linux-kernel@vger.kernel.org
Subject: Re: IDE performance drop between 2.4.23 and 2.6.0 - pinpointed!
Message-ID: <20040103220159.GA22096@sun1000.pwr.wroc.pl>
Reply-To: Pawel Dziekonski <pawel.dziekonski@pwr.wroc.pl>
References: <20030807133053.GA18191@pwr.wroc.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030807133053.GA18191@pwr.wroc.pl>
X-Useless-Header: Vim powered ;^)
X-00-Privacy-Policy: OpenPGP or S/MIME encrypted e-mail is welcome.
X-01-Privacy-Policy-GPG-Key: http://blackhole.pca.dfn.de:11371/pks/lookup?search=dzieko@pwr.wroc.pl&op=get
X-02-Privacy-Policy-GPG-Key_ID: 5AA7253D
X-03-Privacy-Policy-GPG-Key_fingerprint: A80B 5022 185B 1BB5 8848  74C4 A7E1 423C 5AA7 253D
X-04-Privacy-Policy-Personal_SSL_Certificate: http://www.europki.pl/cgi-bin/dn-cert.pl?serial=000001D2&certdir=/usr/local/cafe/data/polish_ca/certs/user&type=email
X-05-Privacy-Policy-CA_SSL_Certificate: http://www.europki.pl/polish_ca/ca_cert/en_index.html
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

same problem here however it seems that i have pinpointed it )at least
for me):

root@localhost:~ # hdparm -ft /dev/hdb

/dev/hdb:
 Timing buffered disk reads:  64 MB in  1.60 seconds = 39.96 MB/sec
root@localhost:~ # 
root@localhost:~ # hdparm -a 256 /dev/hdb

/dev/hdb:
 setting fs readahead to 256
 readahead    = 256 (on)
root@localhost:~ # hdparm -ft /dev/hdb

/dev/hdb:
 Timing buffered disk reads:  64 MB in  1.60 seconds = 39.93 MB/sec
root@localhost:~ # hdparm -ft /dev/hdb

/dev/hdb:
 Timing buffered disk reads:  64 MB in  1.74 seconds = 36.77 MB/sec
root@localhost:~ # hdparm -ft /dev/hdb

/dev/hdb:
 Timing buffered disk reads:  64 MB in  1.60 seconds = 39.91 MB/sec

this is OK! (under 2.4.23-pre8 i get a little bit more than 40)
also changing redaahead to even 8192 gives simmilar results.
also changing it for hda.

now look at this:

modprobe eagle-usb (my adsl modem)
adictrl -w (load firmware to modem , synchronize etc..)

root@localhost:~ # adictrl -w
Sending options to device /proc/bus/usb/001/002
Options successfully sent to driver.
Sending DSP code to device /proc/bus/usb/001/002
DSP code successfully loaded.
Waiting for synchro...
OK .. Modem is synchronized.
root@localhost:~ # 
root@localhost:~ # hdparm -ft /dev/hdb

/dev/hdb:
 Timing buffered disk reads:  64 MB in  3.84 seconds = 16.67 MB/sec
root@localhost:~ # 
root@localhost:~ # hdparm -ft /dev/hdb

/dev/hdb:
 Timing buffered disk reads:  64 MB in  3.67 seconds = 17.42 MB/sec
root@localhost:~ # 
root@localhost:~ # hdparm -ft /dev/hdb

/dev/hdb:
 Timing buffered disk reads:  64 MB in  3.74 seconds = 17.09 MB/sec
root@localhost:~ # umount /proc/bus/usb/
root@localhost:~ # 
root@localhost:~ # 
root@localhost:~ # hdparm -ft /dev/hdb

/dev/hdb:
 Timing buffered disk reads:  64 MB in  3.30 seconds = 19.39 MB/sec
root@localhost:~ # hdparm -ft /dev/hdb

/dev/hdb:
 Timing buffered disk reads:  64 MB in  2.71 seconds = 23.62 MB/sec
root@localhost:~ # hdparm -ft /dev/hdb

/dev/hdb:
 Timing buffered disk reads:  64 MB in  3.57 seconds = 17.91 MB/sec
root@localhost:~ # hdparm -a 8192 /dev/hdb

/dev/hdb:
 setting fs readahead to 8192
 readahead    = 8192 (on)
root@localhost:~ # hdparm -ft /dev/hdb

/dev/hdb:
 Timing buffered disk reads:  64 MB in  3.09 seconds = 20.74 MB/sec
root@localhost:~ # hdparm -ft /dev/hdb

/dev/hdb:
 Timing buffered disk reads:  64 MB in  3.44 seconds = 18.59 MB/sec
root@localhost:~ # hdparm -a 8192 /dev/hda

/dev/hda:
 setting fs readahead to 8192
 readahead    = 8192 (on)
root@localhost:~ # hdparm -ft /dev/hdb

/dev/hdb:
 Timing buffered disk reads:  64 MB in  2.94 seconds = 21.78 MB/sec
root@localhost:~ # hdparm -ft /dev/hdb

/dev/hdb:
 Timing buffered disk reads:  64 MB in  2.58 seconds = 24.80 MB/sec
root@localhost:~ # hdparm -ft /dev/hdb

/dev/hdb:
 Timing buffered disk reads:  64 MB in  2.96 seconds = 21.63 MB/sec
root@localhost:~ # hdparm -t /dev/hdb

/dev/hdb:
 Timing buffered disk reads:  64 MB in  3.59 seconds = 17.82 MB/sec
root@localhost:~ # hdparm -t /dev/hdb

disaster...

funny (? ;-) thing is that under 2.4 i have same issue...

my chipset is kt133 (via), i use uhci.

root@localhost:~ # cat /proc/interrupts 
           CPU0       
  0:    2283127          XT-PIC  timer
  1:       4896          XT-PIC  i8042
  2:          0          XT-PIC  cascade
  8:          1          XT-PIC  rtc
  9:          0          XT-PIC  acpi
 10:          0          XT-PIC  eth0, VIA686A
 11:     271497          XT-PIC  uhci_hcd, uhci_hcd
 12:     171840          XT-PIC  bttv0, nvidia
 14:      33427          XT-PIC  ide0
 15:          1          XT-PIC  ide1
NMI:          0 
ERR:          4

tested under pure 2.6.0.  ac scheduler, same under noop and dead.

regards, Pawel

ps. i read the list via www so cc my the replies please. thanks.
-- 
Pawel Dziekonski <pawel.dziekonski|@|pwr.wroc.pl>, KDM WCSS avatar:0:0:
Wroclaw Networking & Supercomputing Center, HPC Department
-> See message headers for privacy policy info.
