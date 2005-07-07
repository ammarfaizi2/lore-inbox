Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262209AbVGGCfh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262209AbVGGCfh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 22:35:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261847AbVGGCdg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 22:33:36 -0400
Received: from 69-18-3-179.lisco.net ([69.18.3.179]:59145 "EHLO
	ninja.slaphack.com") by vger.kernel.org with ESMTP id S262237AbVGGCcx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 22:32:53 -0400
Message-ID: <42CC9469.9000001@slaphack.com>
Date: Wed, 06 Jul 2005 21:33:13 -0500
From: David Masover <ninja@slaphack.com>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Hubert Chan <hubert@uhoreg.ca>
Cc: Horst von Brand <vonbrand@inf.utfsm.cl>,
       Jonathan Briggs <jbriggs@esoft.com>,
       "Alexander G. M. Smith" <agmsmith@rogers.com>, ross.biro@gmail.com,
       mrmacman_g4@mac.com, Valdis.Kletnieks@vt.edu, ltd@cisco.com,
       gmaxwell@gmail.com, jgarzik@pobox.com, hch@infradead.org, akpm@osdl.org,
       linux-kernel@vger.kernel.org, reiserfs-list@namesys.com,
       zam@namesys.com, vs@thebsh.namesys.com, ndiller@namesys.com,
       vitaly@thebsh.namesys.com
Subject: Re: reiser4 plugins
References: <hubert@uhoreg.ca>	<200507062033.j66KXNqM008212@laptop11.inf.utfsm.cl> <87ackzei41.fsf@evinrude.uhoreg.ca>
In-Reply-To: <87ackzei41.fsf@evinrude.uhoreg.ca>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hubert Chan wrote:
> On Wed, 06 Jul 2005 16:33:23 -0400, Horst von Brand <vonbrand@inf.utfsm.cl> said:
> 
> 
>>Hubert Chan <hubert@uhoreg.ca> wrote:
>>
>>>If you can store the parents, then finding cycles (relatively)
>>>quickly is pretty easy: before you try to make A the parent of B,
>>>walk up the parent pointers starting from A.  If you ever reach B,
>>>you have a cycle.  If not, you don't have a cycle.  (Hmmm.  Do I need
>>>a proof of correctness for this?  It's just depth-first-search, which
>>>everybody learned in their first algorithms course.)
> 
> 
>>Correct. And you need space for potentially a huge lot of up pointers
>>for each file.
> 
> 
> People (that I know of) don't normally have a huge lot of hardlinks to a
> single file.

And speaking of which, the only doomsday scenario (running out of RAM) 
that I can think of with this scheme is if we have a ton of hardlinks to 
the same file and we try to move one of them.  But this scales linearly 
with the number of hardlinks, I think.  Maybe not quite, but certainly 
not exponentially.

The only other doomsday scenario is if we have a ludicrously deep tree.

To make this work in real usage, not DOS testing, we really need both of 
those, and even then I'm not sure it can work.  What's the maximum 
number of hardlinks supported to a single file?  What's the maximum tree 
depth?  Can these be limited to prevent actual DOS attempts?

Now, if we were to ever actually *create* a cycle, then yes, we might 
end up traversing the whole tree to delete it, possibly running out of 
RAM.  But we don't ever actually create cycles except if we were to have 
corruption, which could as easily create cycles in any other FS.
