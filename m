Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751174AbWA2Vlu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751174AbWA2Vlu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jan 2006 16:41:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751177AbWA2Vlu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jan 2006 16:41:50 -0500
Received: from ms-smtp-03.texas.rr.com ([24.93.47.42]:45256 "EHLO
	ms-smtp-03-eri0.texas.rr.com") by vger.kernel.org with ESMTP
	id S1751174AbWA2Vlt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jan 2006 16:41:49 -0500
Message-ID: <43DD366F.9080906@austin.rr.com>
Date: Sun, 29 Jan 2006 15:41:03 -0600
From: Steve French <smfrench@austin.rr.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org,
       keyrings@linux-nfs.org
Subject: Re: [Keyrings] Re: [PATCH 01/04] Add multi-precision-integer maths
 library
References: <1138312694656@2gen.com> <1138312695665@2gen.com> <6403.1138392470@warthog.cambridge.redhat.com> <20060127204158.GA4754@hardeman.nu> <20060128002241.GD3777@stusta.de> <20060128104611.GA4348@hardeman.nu> <1138466271.8770.77.camel@lade.trondhjem.org> <20060128165732.GA8633@hardeman.nu> <1138504829.8770.125.camel@lade.trondhjem.org> <20060129113320.GA21386@hardeman.nu> <20060129122901.GX3777@stusta.de> <1138540148.3002.9.camel@laptopd505.fenrus.org> <43DD2010.7010700@austin.rr.com> <1138567954.17148.4.camel@laptopd505.fenrus.org>
In-Reply-To: <1138567954.17148.4.camel@laptopd505.fenrus.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:

>it's not that kind of thing. It's basically a public key encryption
>step. Putting it in the kernel can only serve one purpose: to be there
>to allow other parts to use this pke for encrypting/signing/verifying
>signatures. 
>  
>
...

>3) to allow kernel pieces to do key things, like the secure nfs parts of
>nfsv4 or ipsec.
>  
>
That can still deadlock.   If write or writepage or writepages requires 
a network frame to be signed and
an upcall occurs in that path ... For example cifs has long had 
signature code in kernel (depends on MD5
code in kernel, which because it is so small has not been controversial 
presumably) and write requests
(which can be necessary to flush inode data when the system is low on 
memory) are signed
and of course of types of frames are signed in cases where various 
semaphores on the parent directory
or inode are held by the vfs. This signing is done in kernel and at 
least when authenticated with NTLM
(and presumably NTLMv2 as well) has turned out to be fairly simple.   
Note that for many or most
cifs servers in modern day domains packet signatures are required by 
default (unlike four or five years
ago when it was less common).   A key issue that I have not worked 
through is whether this would change
as SPNEGO authentication negotiates PKI or Kerberos like tickets - and 
whether any of this in kernel
infrastructure being discussed would be needed for the common case of 
cifs (beyond what
we already have with MD5 packet signatures) or helpful for the case when
Kerberos/SPNEGO authentication is negotiated (code that is not yet 
complete in cifs, but will
probably be 90% done in userspace) because CIFS packet signing when 
Kerberos is
authenticated (or when an alternative some x509/SPNEGO pki variant is 
more commonly
seem from e.g. Windows servers or NAS appliances) different signing code 
may be required -
and since the SMB WriteX frame would have to be signed ... it would be 
very risky to upcall if
we find out that packet signing for the very, very common case (more 
than 2/3 of enterprises today)
of Kerberized cifs sessions requires an encrypting/signing/verifying 
mechanism that is not in kernel.

Beyond the issue of how to handle the newer version of packet signing, 
my main interest in the
calling the keyring code from kernel (from cifs vfs) is using it to 
determining more precisely
what the "kerberos identity" of the current process is (ie what is the 
"user@realm" for the current
process and do I have an authenticated session for him - so I can map 
the right smb_uid (in effect
a handle to the network security context for the smb session) for the 
header of the SMB/CIFS
network file requests coming from any particular process).

A secondary benefit of the keyring infrastructure, an issue that I hear 
frequently from advanced users, an
issue that the kernel keyring may eventually solve is allowing me to 
automatically authenticate without all local
users having to resupply the password for every local mount (in 
particular when /proc/fs/cifs/MultiuserMount
is enabled).   Currently each unique user logged on to a system 
typically authenticates through pam but
kernel code has no access to the password that was supplied earlier at 
logon time, unless it is passed again
explicitly on mount.   There are common cases in which users would logon 
locally with the same userid/password
as they would supply to mount to a remote server (especially when users 
authenticate to a central
security server through pam_winbind or pam_ldap, pam_kerberos) - in 
those cases I hope someday that
an optional pam module is available which saves the password (or in my 
case there is also a one way hash of the
password which would be fine) in the kernel key ring so cifs does not 
have to upcall in the middle of
an operation (from what to cifs is a new user for this mount) to prompt 
the user at runtime for a password (which
would be awful).   Currently users have to mount to the same server (and 
export) multiple times, once with
each uid/user/password combination - and the keyring would solve this if 
there were an optional pam module that
could save passwords (and eventually kerberos tickets too) securely in 
kernel in the keyring.
