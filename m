Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267398AbUBSWUm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 17:20:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267578AbUBSWUm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 17:20:42 -0500
Received: from websrv.werbeagentur-aufwind.de ([213.239.197.241]:58806 "EHLO
	mail.werbeagentur-aufwind.de") by vger.kernel.org with ESMTP
	id S267398AbUBSWUi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 17:20:38 -0500
Subject: Re: dm-crypt, new IV and standards
From: Christophe Saout <christophe@saout.de>
To: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2004@gmx.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <4035334A.7030407@gmx.net>
References: <4035334A.7030407@gmx.net>
Content-Type: text/plain
Message-Id: <1077229237.17707.9.camel@leto.cs.pocnet.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 19 Feb 2004 23:20:37 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Do, den 19.02.2004 schrieb Carl-Daniel Hailfinger um 23:06:

> Would it be sensible (AFAICS there is not technical limitation) to reserve
> 512/1024/2048/whatever bytes at the beginning of every backing device for
> dm-crypt so that the dm-crypt device could get some info about the used
> methods automatically?

All this can be done in userspace by the setup tool. It then tells the
kernel to start the device at a certain offset. It also has the
advantage that you can change your password without needing to reencrypt
your data (you keep your master key in the "superblock" encrypted with
the passphrase).

> So this meta-information superblock could contain the following:
> - A magic string like CRYPTSPACE (like SWAPSPACE2)
> - The key used to encrypt the device (the key would be encrypted with the
> password)
> - The IV algorithm used
> - The cipher used
> - The way the password was hashed
> - If some conversion was underway last time the dm-crypt device was accessed

Exactly. I like the format LVM2 uses. It basically puts the metadata
into a text file with a magic header string there.

> This way, the following benefits would appear:
> - New dm-crypt devices can be differentiated from old cryptoloop ones
> - Since the password is independent of the key, you can change the
> password without reencrypting the entire device.
> - Since the key is independent of the password, you can change the key,
> reencrypt the entire device and still keep your old password.
> - You can change the default IV to something more secure than the current
> default one without having to fear userland breakage.
> - There are multiple ways to hash a password and with the current scheme
> we have to try all of them if we do not know which version of the tools
> was used to create the file.
> - If the device is currently being reencrypted and is halfway through and
> the power fails, we would know that some part of the device is old
> encryption and some part is new encryption.

I've started to write a userspace program for reencryption. I don't know
if this is very clever because I have to lock the part that is currently
beeing reencrypted (deadlocks & co). Perhaps as another dm target like
dm-mirror for pvmove? We'd have to keep a log or something because we
don't *exactly* know what has been successfully written. This would mean
a lot of seeks. It's complicated if it has to be safe against crashes
and power outages.

> - New (more secure) crypto algorithms/ IV generation schemes/ passphrase
> hashing schemes could be added (or even made default) without violating
> the principle of least surprise.

Yes.

> I am not an expert in crypto, so if you tell me this would reduce security
> or cause other problems, I will accept that. I am aware that the more
> information an attacker has, the easier it is for him to break the encryption.

Other people are already doing this. And I'm not a crypt expert either.
I was just interested in device-mapper and just copied the mechanism
cryptoloop used... (but I'm not completely stupid either ;))


