Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262066AbUBWWTk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 17:19:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262086AbUBWWTF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 17:19:05 -0500
Received: from zeus.kernel.org ([204.152.189.113]:7831 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S262085AbUBWWSV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 17:18:21 -0500
Subject: &array considered harmful?
From: "Robert T. Johnson" <rtjohnso@eecs.berkeley.edu>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: David Wagner <daw@eecs.berkeley.edu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 23 Feb 2004 14:11:49 -0800
Message-Id: <1077574309.16259.4.camel@dooby.cs.berkeley.edu>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The kernel has lots of code that takes the address of a local array. 
This works, but it's fragile.  I'd be happy to submit a patch if
everyone agrees that this is a bad programming practice. 

Here's an example of a program that takes the address of an array: 

void func(void) 
{ 
        char A[10]; 
        .... 
        memset(&A, 0, sizeof(A)); 
} 

This works because in C, for a local array, &A == A.  The problem is
that this is very brittle.  If the programmer later decides to allocate
A dynamically, e.g. 

void func(void) 
{ 
        char *A; 
        A = kmalloc(...); 
        .... 
        memset(&A, 0, sizeof(A)); 
} 

then &A is completely different from A, and the code now has a bug. 
Similarly, if the programmer makes A into a parameter, e.g. 

void func(char A[10]) 
{ 
        .... 
        memset(&A, 0, sizeof(A)); 
} 

then A also behaves like a pointer and the code is broken. 

So just about any change to the declaration of A will cause uses of &A
to break.  The good news is that there's no reason to use &A, since just
using "A" will work in all 3 cases: 

void func(void) 
{ 
        char A[10]; 
        .... 
        memset(A, 0, sizeof(A)); 
} 

(Of course, "sizeof(A)" might also break, but that's a separate issue) 

I first noticed this use of &array when using cqual to find user/kernel
pointer bugs in linux.  Since &A has type "pointer to array of char" and
this gets cast to "pointer to void" in the call to memcpy, cqual gets
confused and can generate false positives.  Now, it would be _very_ easy
to change cqual to handle this, but I think it's better to just not use
&A since it breaks easily.  Also, I wonder if this ever comes up in
sparse. 

As I said above, I can generate a patch to eliminate this programming
construct if everyone agrees that it is bad.  What do the kernel
developers think? 

Best, 
Rob 


