Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264685AbUFQBOE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264685AbUFQBOE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jun 2004 21:14:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266333AbUFQBOE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jun 2004 21:14:04 -0400
Received: from lakermmtao11.cox.net ([68.230.240.28]:57482 "EHLO
	lakermmtao11.cox.net") by vger.kernel.org with ESMTP
	id S264685AbUFQBN6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jun 2004 21:13:58 -0400
In-Reply-To: <10430.1087397355@redhat.com>
References: <FC6EBB12-BF27-11D8-95EB-000393ACC76E@mac.com> <1087282990.13680.13.camel@lade.trondhjem.org> <772741DF-BC19-11D8-888F-000393ACC76E@mac.com> <1087080664.4683.8.camel@lade.trondhjem.org> <D822E85F-BCC8-11D8-888F-000393ACC76E@mac.com> <1087084736.4683.17.camel@lade.trondhjem.org> <DD67AB5E-BCCF-11D8-888F-000393ACC76E@mac.com> <87smcxqqa2.fsf@asterisk.co.nz> <8666.1087292194@redhat.com> <10430.1087397355@redhat.com>
Mime-Version: 1.0 (Apple Message framework v618)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <984AC744-BFFB-11D8-8574-000393ACC76E@mac.com>
Content-Transfer-Encoding: 7bit
Cc: Blair Strang <bls@asterisk.co.nz>, Linus Torvalds <torvalds@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: In-kernel Authentication Tokens (PAGs)
Date: Wed, 16 Jun 2004 21:13:52 -0400
To: David Howells <dhowells@redhat.com>
X-Mailer: Apple Mail (2.618)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jun 16, 2004, at 10:49, David Howells wrote:
> Well, userspace can decide that a process should begin a new session. 
> I'd
> envision this as a user gets a session keyring for each login, and so 
> are able
> to use these to hold different sets of credentials that don't 
> interfere with
> each other.
>
> A UID keyring would be too pervasive - a key in there would affect 
> _every_
> process owned by that user - which might be undesirable.
>
> A process keyring wouldn't be pervasive enough. You couldn't, for 
> example, run
> aklog in your shell to get you an AFS token attached to the session, 
> use that
> token several times by running programs and then quit the shell to 
> dispose of
> the token. Each process wanting the token would have to get itself a 
> new token
> by contacting the Kerberos server.

What if we leave the concept of a key-ring as completely general in 
nature,
such that it can be associated with any object without needing to know 
what
that object is.  Then additional key-ring contexts could be created as 
needed
for LSM modules or such.

I gave reasons earlier in this thread of why it is very useful to have 
nested
key-rings, so perhaps we can give each key-ring a "parent" which 
happens to
be an additional key-ring association.  As long as we avoid cyclic 
graphs, that
should give a great increase in flexibility without security problems.

Another complexity is the access control issue.  I would rather not add 
more
LSM hooks if we can avoid it, just to keep the complexity down, so I'm 
thinking
that we could just represent all the information through the filesystem 
and file
descriptors, with a couple of convenient IOCTLs.  That way we could use 
the
existing LSM hooks for filesystem access, and avoid giving sysadmins 
another
system that they must start all over learning to secure.

I've looked at your patch, and it doesn't seem to be general enough to 
allow
user-space to store arbitrary keys in the kernel, one of the features 
that others
have expressed a desire for (see Andy Lutomirski's emails).  With such a
system the most critical aspect to get first is the most flexible way 
to manipulate
such keys without creating too much complexity.

It's essential to be able to tell the difference between different 
types of keys,
especially if we want to let user-space use this to store other kinds 
of keys. We
also need to be able to identify keys by "service" of some sort.  I 
think that
would probably be a key-type specific parameter, but for a Kerberos TGT 
it
could be something like "krbtgt/MY.REALM@MY.REALM".  With a type based
system we could even allow modules that implement additional 
functionality
for certain types (IE something that uses CryptoAPI to do AES in-kernel 
for
extra security).

Hmm, so going along with these ideas, how about this?
/proc/keyring/
	MODE = 555
	DESC = keyringfs, contains keyring metadata
	
	<id>/
		MODE = Access control for entire keyring
		DESC = A keyring entry, referenced by number
		opendir = Increments the ref count to make sure it won't go away.
		
		parent => ../<id>
			DESC = A symlink or hardlink to the parent keyring
		
		<typeid>/
			MODE = 555
			DESC = A numerical "key-type" (KEYTYPE_KRB5)
			
			<service>
				MODE = Access control for a single key
				DESC = The key, accessed as a file.
			
		<typename> => <typeid>/
				DESC = A symlink or hardlink to a type number from
					a type name.  These types could be registered
					by modules that implement them.

There would be IOCTLs on the key-ring dir handles for getting the 
key-ring
number, adding new keys, etc.  On key handles there would be IOCTLs for
deleting the key, revoking access, etc.  We'd also need a few syscalls 
for
creating new key-rings.

Cheers,
Kyle Moffett

