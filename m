Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267482AbUIKEzz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267482AbUIKEzz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Sep 2004 00:55:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267543AbUIKEzz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Sep 2004 00:55:55 -0400
Received: from smtp-roam.Stanford.EDU ([171.64.10.152]:62937 "EHLO
	smtp-roam.Stanford.EDU") by vger.kernel.org with ESMTP
	id S267482AbUIKEzw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Sep 2004 00:55:52 -0400
Message-ID: <414285DF.5040608@myrealbox.com>
Date: Fri, 10 Sep 2004 21:58:07 -0700
From: Andy Lutomirski <luto@myrealbox.com>
User-Agent: Mozilla Thunderbird 0.7.2 (Windows/20040707)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Howells <dhowells@redhat.com>
CC: Andy Lutomirski <luto@myrealbox.com>, linux-kernel@vger.kernel.org
Subject: Re: Where's the key management patchset at?
References: <413DED11.5030700@myrealbox.com>  <20040907033255.78128ebd.akpm@osdl.org> <20040907031856.58f33b99.akpm@osdl.org> <20040904032913.441631e6.akpm@osdl.org> <20040904022656.31447b51.akpm@osdl.org> <20040903224513.0154c1d3.akpm@osdl.org> <24752.1094234169@redhat.com> <12766.1094289316@redhat.com> <14279.1094293508@redhat.com> <13781.1094551789@redhat.com> <14622.1094552807@redhat.com> <22970.1094563283@redhat.com> <13082.1094581810@redhat.com>
In-Reply-To: <13082.1094581810@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Howells wrote:

>>Second, is there a way for a process/user to have "use but not read"
>>access so it could pass the key to a different _userspace_ process
>>(probably a daemon running as root) that wants to read it?  This would
>>be nice for all kinds of things (like ssh agents and such).
> 
> 
> That depends on what you mean by "use but not read" access.
> 
> Keys now have five permissions (View, Link, Write, Read, Search) and these can
> be applied to user, group or other.
> 
> An in-kernel service just requires Search (Use) permission to be able to use a
> key. It calls request_key() to come up with a key from the process's keyrings
> or from userspace.
> 
 > I'll probably have to do it by passing a new type of SCM message over 
AF_UNIX
 > sockets - one that attaches a key and can drop it into the process's 
thread
 > keyring.
 >

I mean that a process would have be permitted to "use" a key (whatever 
that means) but have no right to read the contents, delegating the 
reading to a second process.  This way a process could delegate the act 
of seeing the key contents (computing a signature, for example) to a 
trusted process, limiting the damage if the key-holding program is 
compromised.  This also might allow smart-cards to fit into the model 
(where "use" makes sense but "read" is meant to be physically impossible).

Maybe one way to do this is to have a second UID attached to the key 
(with its corresponding permission mask), the restriction that Read 
without Search is forbidden and the exception that Search is implied by 
a key's presence in a keyring.  You'd also need to prevent the key owner 
from changing the key's permissions if the owner doesn't have Read.

So my hypothetical ssh agent-like program has a key with UID 500: VLS / 
GID whatever: - / 2nd UID 100: R and a setuid-100 program that does 
public-key ops on it.  Then if the user's account is compromised, no one 
gets the private key.

I'm out of town now, so I haven't actually tried any of this.  I'll take 
a look at the code next week.

--Andy
