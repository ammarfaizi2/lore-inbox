Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751055AbWEEJDR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751055AbWEEJDR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 May 2006 05:03:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751053AbWEEJDR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 May 2006 05:03:17 -0400
Received: from nf-out-0910.google.com ([64.233.182.185]:31252 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751055AbWEEJDQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 May 2006 05:03:16 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=TzWgqEXHkyFIW0Z96kUgB690EbH6Looaznar3B0g88DwftuFZt4heiq9qcEPSrPD6O0kFHwV1+s8nLGkH2hYSmRiRbgyhxYrUAGsJUMGQUUfukGdUTq4Zxey3CTX18YVJhOBZizEEaFTZzLx8xnqnLm/mBnJLFXuXjwXznkF0KY=
Message-ID: <445B1561.1020703@gmail.com>
Date: Fri, 05 May 2006 12:05:37 +0300
From: Alon Bar-Lev <alon.barlev@gmail.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Phillip Hellewell <phillip@hellewell.homeip.net>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, viro@ftp.linux.org.uk, mike@halcrow.us,
       mhalcrow@us.ibm.com, mcthomps@us.ibm.com, toml@us.ibm.com,
       yoder1@us.ibm.com, James Morris <jmorris@namei.org>,
       "Stephen C. Tweedie" <sct@redhat.com>, Erez Zadok <ezk@cs.sunysb.edu>,
       David Howells <dhowells@redhat.com>
Subject: Re: [PATCH 0/12: eCryptfs] eCryptfs version 0.1.6
References: <20060504031755.GA28257@hellewell.homeip.net>
In-Reply-To: <20060504031755.GA28257@hellewell.homeip.net>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Phillip Hellewell wrote:
> This patch set constitutes the 0.1.6 release of the eCryptfs
> cryptographic filesystem:
> 

Great work!
I just want to make some notes about the user mode interface.

I think that current security and encryption solutions that
come out these days without a proper smart card support
create a false sense of security for users. So solutions
should first be designed so that a smart card can be used,
and only then provide a passphrase alternative.

This is the first time I've looked on the user mode
keyutils, and it looks quite good. I think that the eCryptfs
should use it more ?correctly? so that keys stored on smart
card may be used.

For example, you can publish a text format of the key data
so that any application can easily and independently
construct this.

A simple example of key content is:
eCryptfs:version:cipher:key
or:
eCryptfs:1:AES256:123DD12ED12312....

You can modify the mount options:
mount -o keytype=type,keydesc=desc,keydata=data

So that any specific key may be provided, and not only keys
derived from a passphrase. And a proper key may be
instantiate from the kernel.

User may already have this key available using keyctl. The
key may be available from any place.

But if the key is not available, the following
request-key.conf this may be written:

---
create user eCryptfs:p11-data:*
|/usr/bin/eCryptfs-key-p11-data /etc/eCryptfs-key-p11-data.conf

create user eCryptfs:pass:* |/usr/bin/eCryptfs-key-pass
---

This will construct the key from the data if the key is not
available.

For PKCS#11 the providers listed in the conf file, key may
be stored as a data object, and data may be:
	cipher:slot-type:slot:application:label:PIN
	Where:
		slot-type
			slot	- slot id
			name	- slot name
			label	- token label

	?Calling without a PIN may allow prompt for dialog
	via a named pipe to a running daemon by uid?

For passphrase the data may be the cipher:passphrase.

Another issue is a multi user access without a shared
secret. This may be done by encrypting the symmetric key in
several asymmetric ones. Again this can be done in user
mode... But there is a need to support reencrypting the
whole filesystem with a new symmetric key so that a user may
be removed from the list.

In order to support this mode using smart cards when key is
unavailable, the following request-key.conf may be written:

---
create user eCryptfs:p11-multi:*
|/usr/bin/eCryptfs-key-p11-multi
/etc/eCryptfs-key-p11-multi.conf
---

Now the data may be:
	cipher:slot-type:slot:id-type:id:PIN
	Where:
		slot-type
			slot	- slot id
			name	- slot name
			label	- token label
		id-type
			id	- CKA_ID
			label	- CKA_LABEL
			subject	- certificate subject


I hope I understood correctly the various components.

If you like, I will be happy to help you with the user mode
stuff, and implement the smart card access.

Best Regards,
Alon Bar-Lev

