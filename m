Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265251AbUBAKHX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Feb 2004 05:07:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265252AbUBAKHX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Feb 2004 05:07:23 -0500
Received: from mx1.redhat.com ([66.187.233.31]:53187 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S265251AbUBAKHK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Feb 2004 05:07:10 -0500
Message-ID: <401CCF8A.2010406@redhat.com>
Date: Sun, 01 Feb 2004 00:06:02 -1000
From: Warren Togami <wtogami@redhat.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031225 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Fabrice Bellet <fabrice@bellet.info>, fedora-devel-list@redhat.com,
       linux-kernel@vger.kernel.org, Bill Nottingham <notting@redhat.com>,
       csmith@redhat.com
Subject: Re: Trouble with Cisco Airo MPI350 and kernel-2.6.1+
References: <4014AA49.8050800@redhat.com> <20040127164031.GA13174@bellet.info>
In-Reply-To: <20040127164031.GA13174@bellet.info>
X-Enigmail-Version: 0.82.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fabrice Bellet wrote:
> Hi Warren,
> 
> On Sun, Jan 25, 2004 at 07:48:57PM -1000, Warren Togami wrote:
> 
>>IBM Thinkpad T41
>>Cisco Airo MPI350 802.11b Wireless
>>PCIID: 0x14b9  0xa504
>>Kernel: Fedora rawhide 2.6.1-1.57 (Based on 2.6.2-rc1)
>>
>>http://bellet.info/~bellet/laptop/t40.html#wireless
>>http://bellet.info/~bellet/laptop/airo.c-2.6.1-mm2.diff
>>airo.ko does not support this Airo device, but with the addition of this 
>>patch it recognizes the device.
> 
> 
> What is the firmware version (in /proc/driver/aironet/eth0/Status) ?

5.20.17

> Currently, only versions 5[b].00.xx are supported by this patch. More recent
> firmwares changed the card's behaviour in a way that prevents it to 
> associate to the access point. But, I'm a bit surprised by this kind of 
> error, because, even with an unsupported firmware, I can set the WEP key 
> without error with iwconfig.

I tested the following firmware versions and all failed identically to 
set the WEP key in Linux.

5.30.17
5.20.17
5.02.20

> 
> You may want to downgrade the firmware, if needed, with the ACU tool under 
> Windows _only_. You also can try to set the WEP key with ACU too. A linux 
> version of this tool is available for linux, from :
> http://www.cisco.com/pcgi-bin/tablebuild.pl/aironet-utils-linux
> This version works with the linux cisco driver, and also with airo.
> 

Used the ACU tool under Windows XP for flashing the firmware.  The 
newest firmware version that operates with your driver is:
5.00.03

Perhaps mention within a comment and/or config Help of your patch that 
the newest supported firmware is 5.00.03?  That would save people like 
me a lot of time in the future...

> Maybe this error occurs because no wep key has ever been stored in 
> the card's non-volatile memory. The cisco card has two locations to 
> store the wep keys : a volatile, and a non-volatile memory. The linux 
> driver sets the key in both places in writeWepKeyRid(), when perm=1.
> You seem to have a problem to store the key in the non-volatile
> location (WEP_PERM).  The ACU program gives the possibility to choose 
> this location.
> 

Tested this theory.  It seems that airo is unable to set the WEP key 
after ACU has done so.

So your airo driver is working with the 5.00.03 firmware, but there is 
this one remaining issue.  notting@redhat.com mentioned it is failing to 
"rename" something but I cannot remember the details.

During bootup it fails to recognize the airo device exists.  iwconfig 
shows some weird "devXXXXX" device that is not associated with an ethX 
name.  rmmod airo gets rid of it, and afterward ifup works.  The "Set 
Mode" error is harmless.  It subsequently works.  Any ideas?

Bringing up interface eth1:  airo device eth1 does not seem to be 
present, delaying initialization

[root@ibmlaptop root]# iwconfig eth1
Warning: Driver for device dev13905 has been compiled with version 16
of Wireless Extension, while this program is using version 15.
Some things may be broken...

dev13905  IEEE 802.11-DS  ESSID:"tsunami"
           Mode:Managed  Frequency:2.442GHz  Access Point: FF:FF:FF:FF:FF:FF
           Bit Rate:11Mb/s   Tx-Power=20 dBm   Sensitivity=0/0
           Retry limit:16   RTS thr:off   Fragment thr:off
           Encryption key:off
           Power Management:off
           Link Quality:176/0  Signal level:-105 dBm  Noise level:-105 dBm
           Rx invalid nwid:154  Rx invalid crypt:0  Rx invalid frag:0
           Tx excessive retries:0  Invalid misc:171   Missed beacon:0

[root@ibmlaptop root]# rmmod airo
airo: Unregistering dev13905
divert: freeing divert_blk for dev13905

[root@ibmlaptop root]# ifup eth1
Error for wireless request "Set Mode" (8B06) :
     SET failed on device eth1 ; Invalid argument.

[root@ibmlaptop root]# iwconfig eth1
Warning: Driver for device eth1 has been compiled with version 16
of Wireless Extension, while this program is using version 15.
Some things may be broken...

eth1      IEEE 802.11-DS  ESSID:"apophis"  Nickname:"blah"
           Mode:Managed  Frequency:2.412GHz  Access Point: 00:0C:41:75:D4:02
           Bit Rate:11Mb/s   Tx-Power=20 dBm   Sensitivity=0/0
           Retry limit:16   RTS thr:off   Fragment thr:off
           Encryption key:****-****-**   Security mode:open
           Power Management:off
           Link Quality:49/0  Signal level:-84 dBm  Noise level:-98 dBm
           Rx invalid nwid:5  Rx invalid crypt:0  Rx invalid frag:0
           Tx excessive retries:0  Invalid misc:253   Missed beacon:0

Warren Togami
wtogami@redhat.com
