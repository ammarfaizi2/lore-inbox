Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269523AbTGJUOM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 16:14:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266463AbTGJUN7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 16:13:59 -0400
Received: from netrider.rowland.org ([192.131.102.5]:33042 "HELO
	netrider.rowland.org") by vger.kernel.org with SMTP id S266446AbTGJUNd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 16:13:33 -0400
Date: Thu, 10 Jul 2003 16:28:09 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To: linux-kernel@vger.kernel.org
Subject: Style question: Should one check for NULL pointers?
Message-ID: <Pine.LNX.4.44L0.0307101606060.22398-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There are many places in the kernel where a function checks whether a
pointers it has been given is NULL.  Now sometimes this makes perfect
sense because the function's description explicitly says that a NULL
pointer argument is valid.  But in many, many cases (maybe even the
majority) it is nothing more than paranoia: the pointer can never be NULL
in a properly functioning system.

Should these checks be made?  I claim they should not.

Suppose everything is working correctly and the pointer never is NULL.  
Then it really doesn't matter whether you check or not;  the loss in code
speed and size is completely negligible (except maybe deep in some inner
loop).  But there is a loss in code clarity; when I see a check like that
it makes me think, "What's that doing there?  Can that pointer ever be
NULL, or is someone just being paranoid?"  Distractions of that sort don't
help when trying to read code.

On the other hand, what if on rare occasions the pointer actually is NULL,
even though it's not supposed to be?  This can only be the result of an
error somewhere else in the kernel (such as incorrect locking during a
data structure update).  Detecting the NULL pointer and returning an error
code will hide the existence of the true underlying error.  But if the
check _isn't_ made, then as soon as the pointer is derefenced there will
be a nice big segfault.  This will immediately alert people to the
existence of a problem, something they otherwise might not be aware of at
all.

Ultimately this comes down to a question of style and taste.  This 
particular issue is not addressed in Documentation/CodingStyle so I'm 
raising it here.  My personal preference is for code that means what it 
says; if a pointer is checked it should be because there is a genuine 
possibility that the pointer _is_ NULL.  I see no reason for pure 
paranoia, particularly if it's not commented as such.

Comments, anyone?

Alan Stern

