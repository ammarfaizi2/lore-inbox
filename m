Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262473AbTENQhl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 12:37:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262524AbTENQhh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 12:37:37 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:50953 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S262473AbTENQhX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 12:37:23 -0400
Date: Wed, 14 May 2003 09:49:42 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: David Howells <dhowells@redhat.com>
cc: linux-kernel@vger.kernel.org, <linux-fsdevel@vger.kernel.org>,
       <openafs-devel@openafs.org>
Subject: Re: [PATCH] PAG support, try #2
In-Reply-To: <24225.1052909011@warthog.warthog>
Message-ID: <Pine.LNX.4.44.0305140924040.3107-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 14 May 2003, David Howells wrote:
> 
> Here's a revised patch for adding PAG support that incorporates suggestions
> and corrections I've been sent.

I still really don't like this, and think it needs to be thought through a 
_lot_ more.  I also think this is _way_ waaaay too late to get into 
2.6.x anyway.

Anyway, the thing I think is just fundamentally broken about this is

 - I'm convinced this is designed for AFS, and not for any practical use.
   For example, the "PAG" identifier (pag_t) is not any bigger than 
   "uid_t", which means that there is no sane way to map users onto pags 
   without just making them 1:1.

   Which looks like a frigging _bad_ design, one that doesn't take account
   of what a normal user (and current AFS/Kerberos users are by design
   _not_ normal users) might want to have through something like "pam".

 - A token can be on only one pag, which means that you have to duplicate 
   tokens and then have a very hard time revocing them if you want to. In 
   other words, you can never give another user (which by implication is
   always another pag in my mind) a token, since you've now effectively 
   lost the ability to invalidate it (the other user gets a copy of the 
   token).

   End result: again, this looks like it is designed for the _wrong_ usage 
   of sharing a whole PAG or sharing nothing at all. Which is probably 
   what current AFS users do, but it sounds inflexible and _wrong_ to me. 
   The main PAG usage I personally envision would be something where the
   PAG contains the decryption key to a filesystem or similar, which 
   definitely is something where you (a) want to have multiple keys and
   (b)  you want to have multiple PAG's that can share some keys without
   being the same PAG.

I suspect both of these problems could be fixed by another level of
indirection: a "user credential" is really a "list of PAG's", with the PAG
being a "list of keys". Joining a PAG _adds_ that PAG to the user 
credentials, instead of replacing the old credentials with the new one.

And "pag_t" needs to be bigger, at least 64 bits. That, together with the
"credential == 'list of PAG'" thing means that you can choose to do things
like:

 - high bits zero, low bits match the UID (ie all users automatically get 
   their own "private PAG", PAM just does the joining automatically)

   I personally _require_ this. End of discussion. Anything that doesn't 
   allow for user-friendly automatic PAG's is, in my not-so-humble 
   opinion, a total waste of time, and complete CRAP.

   Did I make my opinion clear enough? In other words, when I log in, I 
   want to automatically get certain credentials, and I consider the
   log-in sequence to be sufficient security for those credentials. 

   Anything that isn't designed for this is WRONG.

 - high bits "group pattern", low bits "GUID" - same thing as UID. Some 
   PAG's are automatically associated with the _group_ ID of the person. 
   When I log in, and I'm in the "engineering" group, I should
   automatically get access to the "engineering PAG". 

 - users can controlledly join other PAGs as they wish (ie if you want to 
   have credentials that are on top of the automatic user credentials, you
   have to join them explicitly, which migth require a stronger password
   or something)

   This allows for the "extra" credentials, and it also allows for users 
   joining each others PAG's at least temporarily. It also allows things 
   like extra groups outside of the traditional scope of groups (ie you 
   can set up ad-hoc groups by creating a new PAG, and letting others join
   it).

Anyway, I htink the current patch is totally unusable for any reasonable 
MIS setup (ie you couldn't make it useful as a PAM addition even if you 
tried), and is totally special-cased for one (not very interesting, to me) 
use.

And I think this will be a 2.7.x issue, if only because you guys will need 
to convince me that I'm wrong.

		Linus

