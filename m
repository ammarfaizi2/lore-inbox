Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262876AbTIGHXf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Sep 2003 03:23:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262893AbTIGHXf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Sep 2003 03:23:35 -0400
Received: from pix-525-pool.redhat.com ([66.187.233.200]:22882 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id S262876AbTIGHXd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Sep 2003 03:23:33 -0400
Date: Sun, 7 Sep 2003 03:23:22 -0400 (EDT)
From: Ingo Molnar <mingo@redhat.com>
X-X-Sender: mingo@devserv.devel.redhat.com
To: Hugh Dickins <hugh@veritas.com>
cc: Jamie Lokier <jamie@shareable.org>, Rusty Russell <rusty@rustcorp.com.au>,
       Andrew Morton <akpm@osdl.org>, <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 2] Little fixes to previous futex patch
In-Reply-To: <Pine.LNX.4.44.0309042224240.5364-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0309070322310.17404-100000@devserv.devel.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


btw., regarding this fix:

  ChangeSet@1.1179.2.5, 2003-09-06 12:28:20-07:00, hugh@veritas.com
    [PATCH] Fix futex hashing bugs

why dont we do this:

                        } else {
                                /* Make sure to stop if key1 == key2 */
				if (head1 == head2)
					break;
                                list_add_tail(i, head2);
                                this->key = key2;
                                if (ret - nr_wake >= nr_requeue)
                                        break;
                        }

instead of the current:

                        } else {
                                list_add_tail(i, head2);
                                this->key = key2;
                                if (ret - nr_wake >= nr_requeue)
                                        break;
                                /* Make sure to stop if key1 == key2 */
                                if (head1 == head2 && head1 != next)
                                        head1 = i;
                        }

what's the point in requeueing once, and then exiting the loop by changing
the loop exit condition variable? You are trying to avoid the lockup but
the first one ought to be the most straightforward way to do it.

	Ingo



