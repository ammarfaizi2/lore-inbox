Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263115AbTDBST1>; Wed, 2 Apr 2003 13:19:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263120AbTDBST1>; Wed, 2 Apr 2003 13:19:27 -0500
Received: from tag.witbe.net ([81.88.96.48]:35084 "EHLO tag.witbe.net")
	by vger.kernel.org with ESMTP id <S263115AbTDBSTZ>;
	Wed, 2 Apr 2003 13:19:25 -0500
From: "Paul Rolland" <rol@as2917.net>
To: <linux-kernel@vger.kernel.org>
Cc: "'Paul Rolland'" <rol@as2917.net>
Subject: i810-tco : odd behavior, odd driver ?
Date: Wed, 2 Apr 2003 20:30:50 +0200
Message-ID: <028c01c2f945$fcc0d230$3f00a8c0@witbe>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.3416
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I'm using a Super P4SGE motherboard, that does include the i810 
watchdog.
I did compile a 2.4.20 Linux kernel with support for this watchdog,
but the results are rather strange, as the machine keeps rebooting
every 5-6 minutes :
last says :
....
reboot   system boot  2.4.20-watchdog  Wed Apr  2 17:16          (00:52)

reboot   system boot  2.4.20-watchdog  Wed Apr  2 17:09          (00:59)

reboot   system boot  2.4.20-watchdog  Wed Apr  2 17:03          (01:05)

reboot   system boot  2.4.20-watchdog  Wed Apr  2 16:59          (01:09)

reboot   system boot  2.4.20-watchdog  Wed Apr  2 16:54          (01:14)

reboot   system boot  2.4.20-watchdog  Wed Apr  2 16:49          (01:19)

reboot   system boot  2.4.20-watchdog  Wed Apr  2 16:44          (01:23)

reboot   system boot  2.4.20-watchdog  Wed Apr  2 16:38          (01:30)

reboot   system boot  2.4.20-watchdog  Wed Apr  2 16:30          (01:38)

...

The code to stop the watchdog is :
int getWatchdogFd(void)
{
  int fd;

  fd = open("/dev/watchdog", O_RDWR);
  if (-1 == fd)
    printf("Error opening /dev/watchdog : %s\n", strerror(errno));

  return(fd);
}
...
        fd = getWatchdogFd();
        option = WDIOS_DISABLECARD;
        if (-1 == ioctl(fd, WDIOC_SETOPTIONS, &option)) {
          printf("Error disabling watchdog [%d]\n", errno);
        } else {
          printf("Watchdog disabled\n");
        } /* endif */
        write(fd,"V",1);
        close(fd);

Calling this code results in some OK, and at least, by writing 'V', I
don't have the "Unexpected close, not stopping watchdog!" message.

By changing the driver code, I now know that the hardware I have is 
identified as :
PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801E_0
in the PCI table list.

So, I went to Intel documentation, and I got two big points :
Doc 273599-001, Page 278 :
TCO1_TMR : The timer is clocked approximately 0.6 seconds, and this
allows
time-outs ranging from 2.4 s to 38 s.

-> How is it possible that my system waits from 5-6 minutes before
restarting,
when the driver initialized this time-out to 30 seconds, as it is the
default
value ???

Same doc, page 281 :
TCO1_CNT is a 16bits register.
While I was at school, I was told that accessing a 16bits reg must be
done using 16bit operands.
The code, however does some awful :
unsigned char val;
val = inb(TCO1_CNT + 1)
and does access the 8higher bit by reading an 8 bit value at the 
register address + 1....
Is this correct ?

What can I do / test / ??? to have this watchdog running ?

Regards,
Paul, rol@as2917.net

