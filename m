Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932334AbWHaOav@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932334AbWHaOav (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 10:30:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932333AbWHaOav
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 10:30:51 -0400
Received: from igw2.watson.ibm.com ([129.34.20.6]:61831 "EHLO
	igw2.watson.ibm.com") by vger.kernel.org with ESMTP id S932331AbWHaOat
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 10:30:49 -0400
Subject: Re: [RFC][PATCH 8/8] SLIM: documentation
From: David Safford <safford@watson.ibm.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: Mimi Zohar <zohar@us.ibm.com>, Crispin Cowan <crispin@novell.com>,
       David Safford <safford@us.ibm.com>, kjhall@us.ibm.com,
       linux-kernel <linux-kernel@vger.kernel.org>,
       LSM ML <linux-security-module@vger.kernel.org>,
       linux-security-module-owner@vger.kernel.org,
       Serge E Hallyn <sergeh@us.ibm.com>
In-Reply-To: <20060830234627.GM3923@elf.ucw.cz>
References: <20060830225950.GI3923@elf.ucw.cz>
	 <OF47A7AF49.EC4403C3-ON852571DA.00818B73-852571DA.006C6E56@us.ibm.com>
	 <20060830234627.GM3923@elf.ucw.cz>
Content-Type: text/plain
Date: Thu, 31 Aug 2006 10:30:45 -0400
Message-Id: <1157034645.2724.79.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-08-31 at 01:46 +0200, Pavel Machek wrote:
> So... will I be able to set ~/.ssh/private_key to USER-SENSITIVE and
> still use ssh to log in to remove machines? Will trojans coming from
> network be able to read that file?
> 
> I do not think see how that can work... because ssh accesses network,
> and needs to know my private_key.
> 								Pavel

In an earlier post, I briefly mentioned using restructuring or a TPM 
for the ssh case, but I didn't explain it well at all. I'll try to 
do better:

You are absolutely correct that with the existing ssh implementation,
simply labeling an ssh private key as USER-SENSITIVE would be safe,
but would prevent ssh from writing to the PUBLIC network, which would 
cause it to fail. 

You could then make the ssh executable a secrecy guard, so that it
could read the private keys, and still write to the PUBLIC network,
but then, if the ssh process is compromised, the keys could be
leaked. This is still much better than discretionary access control, 
as it prevents all other programs which are not explicitly labeled 
as a secrecy guard from giving the keys away, but by making ssh a guard, 
you are explicitly allowing it to access sensitive data and still
talk on a public connection. This is the inherent behavior of any 
mandatory access control system; you label things and then either 
allow access, or not.

One approach is then to minimize the amount of code you have to trust,
by restructuring the application. In the case of ssh, you could 
separate out the code that uses the private key to do the actual
public key decryption into a small separate program, which has
to be trusted, and keep the rest of ssh, which handles the bulk
of the untrusted data, in a large untrusted program. Postfix 
(www.postfix.org) is an excellent example of restructuring a large 
monolithic program like sendmail, into small isolated components, 
for better security and robustness, and this application structuring
complements MAC systems by reducing the trust granularities.

A better approach is to not let _any_ software see the private key, 
by using a hardware device, such as a TPM, to create the private key
in the first place, and to do the actual public key operation. 
(http://sourceforge.net/projects/trousers/ has open source applications
and libraries for TPM based openssl and pkcs11 crypto.) Then, even if ssh 
is compromised, it can't give the private key away. 

The bottom line is that mandatory access control helps significantly by
preventing any other application from leaking the ssh keys, and by 
forcing you to designate ssh as trusted not to leak the keys. But
once you designate ssh as trusted, then it is up to other security 
techniques, such as structuring, and hardware to protect the keys
further.

dave






