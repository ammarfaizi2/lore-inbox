Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964899AbVLMJfO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964899AbVLMJfO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 04:35:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964897AbVLMJfO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 04:35:14 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:41188 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S964888AbVLMJfM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 04:35:12 -0500
Date: Tue, 13 Dec 2005 10:34:27 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Andi Kleen <ak@suse.de>
Cc: Arjan van de Ven <arjan@infradead.org>, Andrew Morton <akpm@osdl.org>,
       David Howells <dhowells@redhat.com>, torvalds@osdl.org,
       hch@infradead.org, matthew@wil.cx, linux-kernel@vger.kernel.org,
       linux-arch@vger.kernel.org
Subject: Re: [PATCH 1/19] MUTEX: Introduce simple mutex implementation
Message-ID: <20051213093427.GA26097@elte.hu>
References: <dhowells1134431145@warthog.cambridge.redhat.com> <20051212161944.3185a3f9.akpm@osdl.org> <20051213075441.GB6765@elte.hu> <1134460804.2866.17.camel@laptopd505.fenrus.org> <20051213090349.GE10088@elte.hu> <20051213090917.GC15804@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051213090917.GC15804@wotan.suse.de>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andi Kleen <ak@suse.de> wrote:

> > it's not _that_ bad, if done overnight. It does not touch any of the 
> > down/up APIs. Touching those would create a monster patch and monster 
> > impact.
> 
> One argument for a full rename (and abandoning the old "struct 
> semaphore" name completely) would be that it would offer a clean break 
> for out tree code, no silent breakage.

yeah. Another way to handle it would be to keep 'struct semaphore' for 
the traditional semaphore type (together with the APIs), and to mark 
them deprecated. I.e. we'd have 3 separate types and 3 separate sets of 
APIs:

 'struct mutex' & APIs
 'struct semaphore' & APIs
 'struct compat_semaphore' & APIs

phase #1: we do an overnight rename to 'struct mutex' and to
          'struct compat_semaphore', based on the info that has been 
          mapped by the -rt tree. We mark 'struct semaphore' deprecated.

phase #2: we let out-of-tree code still work that uses struct 
          semaphore, but for new code applied, it must not be used.

phase #3: we remove 'struct semaphore' and APIs.

the problem with this approach is that it touches the semaphore APIs 
too, which increases the impact of the rename by a _factor of 10_. Right 
now we have ~600 places that use 'struct semaphore', but we have over 
7000 places that use the APIs! I dont think it's realistic to do an 
overnight change of all the APIs, we'd break every out-of-kernel tree in 
a massive way. (the type change alone is much more manageable)

	Ingo
