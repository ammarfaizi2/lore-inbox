Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264467AbTLLEYW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Dec 2003 23:24:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264472AbTLLEYW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Dec 2003 23:24:22 -0500
Received: from k-kdom.nishanet.com ([65.125.12.2]:44044 "EHLO
	mail2k.k-kdom.nishanet.com") by vger.kernel.org with ESMTP
	id S264467AbTLLEYT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Dec 2003 23:24:19 -0500
Message-ID: <3FD94778.2020606@nishanet.com>
Date: Thu, 11 Dec 2003 23:43:36 -0500
From: Bob <recbo@nishanet.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031205 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: udev for dummies
References: <20031211221604.GA2939@werewolf.able.es> <1071183521.5900.36.camel@dhollis-lnx.kpmg.com>
In-Reply-To: <1071183521.5900.36.camel@dhollis-lnx.kpmg.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David T Hollis wrote:

>On Thu, 2003-12-11 at 17:16, J.A. Magallon wrote:
>  
>
>>Hi all...
>>
>>I am starting to use 2.6, and I really would like to use udev.
>>But I can't find a doc about how to move from taditional heavily
>>populated /dev to new method.
>>
>>Any pointer ?
>>
Do you may mean heavily **over-populated**
/dev? Learning more about devfs would make it
easier to transition to udev. I'm going through this
now for myself.

You could learn how to strip out non-existent
devices from /dev by using
 /etc/devfs/compat_symlinks
by using regular expressions there to make symlinks
for standard device names like udev uses but only
permit devfsd to make device entries for devices
you have on your system.

Here is my /etc/devfs/compat_symlinks. At the
top I don't use anything but devfs naming, then
at the bottom I add a few symlinks both to limit
naming to real devices(see md*) and to make
conventional sd* hd* to make transition to
udev simpler.

-Bob

# Enable full compatibility mode for old device names. You may comment these
# out if you don't use the old device names. Make sure you know what you're
# doing!
#########REGISTER	.*		MKOLDCOMPAT
UNREGISTER	.*		RMOLDCOMPAT

# You may comment out the above and uncomment the following if you've
# configured your system to use the original "new" devfs names or the really
# new names
#####REGISTER	^vc/.*		MKOLDCOMPAT
UNREGISTER	^vc/.*		RMOLDCOMPAT
#####REGISTER	^pty/m0  	MKOLDCOMPAT
######REGISTER	^pty/s0  	MKOLDCOMPAT
UNREGISTER	^pty/.*		RMOLDCOMPAT
######REGISTER	^misc		MKOLDCOMPAT
UNREGISTER	^misc		RMOLDCOMPAT

# You may comment these out if you don't use the original "new" names
######REGISTER	.*		MKNEWCOMPAT
UNREGISTER	.*		RMNEWCOMPAT

# Create compatibility links for broken USB serial driver
REGISTER	^usb/tts/([0-9]+) CFUNCTION GLOBAL symlink $devname ttyUSB\1
#######UNREGISTER	^usb/tts/([0-9]+) CFUNCTION GLOBAL unlink ttyUSB\1

# Create compatibility link for broken misc/net/tun driver (must uncomment the
# MKOLDCOMPAT for misc above if you want to use this)
######REGISTER	^misc/net/tun$	CFUNCTION GLOBAL unlink   net/tun
######REGISTER	^misc/net/tun$	CFUNCTION GLOBAL symlink  /dev/$devname net/tun

# Bob removes non-existent /dev/md's, adds old conventional devices
# to aid transition to udev as this percolates through /etc/init.d
# scripts for fsck and mount--
REGISTER	^md/[0-4]		             MKOLDCOMPAT
UNREGISTER	^md/[5-9][0-9]*	                     RMOLDCOMPAT
REGISTER        ^ide/host[0-2]/.*                    MKOLDCOMPAT
REGISTER        ^scsi/host[0-2]/bus0/target[0-3]/.*  MKOLDCOMPAT
REGISTER        ^snd/.*                              MKOLDCOMPAT
REGISTER        ^sound/.*                            MKOLDCOMPAT
REGISTER        ^misc/rtc                            MKOLDCOMPAT





