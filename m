Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267386AbUBSWHX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 17:07:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267582AbUBSWHX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 17:07:23 -0500
Received: from pop.gmx.net ([213.165.64.20]:29629 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S267386AbUBSWGr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 17:06:47 -0500
X-Authenticated: #21910825
Message-ID: <4035334A.7030407@gmx.net>
Date: Thu, 19 Feb 2004 23:06:02 +0100
From: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2004@gmx.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030821
X-Accept-Language: de, en
MIME-Version: 1.0
To: christophe@saout.de
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: dm-crypt, new IV and standards
X-Enigmail-Version: 0.76.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

after having read what I believe to be all dm-crypt related mails on lkml,
I have a question which I could not find an answer for:
(and I noticed Andrew Morton worrying about backwards compatibility)

Would it be sensible (AFAICS there is not technical limitation) to reserve
512/1024/2048/whatever bytes at the beginning of every backing device for
dm-crypt so that the dm-crypt device could get some info about the used
methods automatically?

So this meta-information superblock could contain the following:
- A magic string like CRYPTSPACE (like SWAPSPACE2)
- The key used to encrypt the device (the key would be encrypted with the
password)
- The IV algorithm used
- The cipher used
- The way the password was hashed
- If some conversion was underway last time the dm-crypt device was accessed

This way, the following benefits would appear:
- New dm-crypt devices can be differentiated from old cryptoloop ones
- Since the password is independent of the key, you can change the
password without reencrypting the entire device.
- Since the key is independent of the password, you can change the key,
reencrypt the entire device and still keep your old password.
- You can change the default IV to something more secure than the current
default one without having to fear userland breakage.
- There are multiple ways to hash a password and with the current scheme
we have to try all of them if we do not know which version of the tools
was used to create the file.
- If the device is currently being reencrypted and is halfway through and
the power fails, we would know that some part of the device is old
encryption and some part is new encryption.
- New (more secure) crypto algorithms/ IV generation schemes/ passphrase
hashing schemes could be added (or even made default) without violating
the principle of least surprise.

I am not an expert in crypto, so if you tell me this would reduce security
or cause other problems, I will accept that. I am aware that the more
information an attacker has, the easier it is for him to break the encryption.


Regards,
Carl-Daniel

