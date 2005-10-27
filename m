Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751520AbVJ0AR5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751520AbVJ0AR5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Oct 2005 20:17:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751522AbVJ0AR5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Oct 2005 20:17:57 -0400
Received: from plasma.querx.com ([66.59.109.191]:64491 "EHLO plasma.querx.com")
	by vger.kernel.org with ESMTP id S1751520AbVJ0AR4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Oct 2005 20:17:56 -0400
Message-ID: <43601CAF.1080508@raxnet.net>
Date: Wed, 26 Oct 2005 20:17:51 -0400
From: Ian Berry <iberry@raxnet.net>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050724)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: cifsoplockd oops in 2.6.13.4
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have been experiencing problems with cifs-mounted Windows (2k/2k3) 
shares running under the 2.6.13.4 kernel. I am running a piece of 
software that traverses a remote cifs mount for backup purposes. To 
prevent locking issues, the script obtains a shared lock on each file 
before trying to read it and releases it afterwards. After making this 
change, running the script for an extended period of time causes the 
cifs process in the kernel to oops and eventually require a reboot to 
fully recover.

As I *was* using a stock 2.6.11 kernel, the changelogs for 2.6.12 and 
2.6.13 looked promising with new code that would prevent an oops when 
the oplockd thread dies and another fix for an oops when closing a file 
with open locks. Unfortunately, upgrading the kernel to 2.6.13.4 has not 
corrected the problem although it seems to take longer for the problem 
to manifest itself.

Here is what appears in dmesg:

Process cifsoplockd (pid: 192, threadinfo=f7cd2000 task=c1be7020)
Stack: f380940c ffffffff c013fc03 f3809400 f7cd3f4c 00000000 00000000 
f7cd3f44
       00000000 f7cd2000 c014a16e f38093fc 00000000 0000000e f7cd3f4c 
00000000
       c014a6e9 f7cd3f44 f38093fc 00000000 0000000e 00000000 00000000 
00000000
Call Trace:
  [<c013fc03>] find_get_pages+0x53/0x60
  [<c014a16e>] pagevec_lookup+0x2e/0x40
  [<c014a6e9>] invalidate_mapping_pages+0x59/0x100
  [<c022ce5b>] CIFSSMBLock+0x7b/0x1e0
  [<c022b452>] cifs_oplock_thread+0x112/0x214
  [<c022b340>] cifs_oplock_thread+0x0/0x214

I have confirmed that the cifsoplockd process does in fact die after 
this occurs. I also saw a note in the 2.6.13 changelog that the cifs 
locking code is still not perfect, but improved. Can anyone confirm this?

The box in question is a Dell 2850 w/ 2x2.8 GHz Xeon processors. I have 
been able to reproduce this on multiple servers as well.

Thanks,

Ian
