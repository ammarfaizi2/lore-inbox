Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288986AbSAZCQm>; Fri, 25 Jan 2002 21:16:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288987AbSAZCQd>; Fri, 25 Jan 2002 21:16:33 -0500
Received: from femail29.sdc1.sfba.home.com ([24.254.60.19]:35809 "EHLO
	femail29.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S288986AbSAZCQN>; Fri, 25 Jan 2002 21:16:13 -0500
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
To: linux-kernel@vger.kernel.org
Subject: Really odd behavior of overlapping named pipes?
Date: Fri, 25 Jan 2002 13:13:58 -0500
X-Mailer: KMail [version 1.3.1]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020126021610.YKAU20810.femail29.sdc1.sfba.home.com@there>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You apparently can't share named pipe instances.  They short-circuit.  When I 
open four command shells, do a mkfifo /tmp/fifo, and then do the following:

Shell one and two:

cat /tmp/mkfifo

Shell three and four:

cat > /tmp/mkfifo

Both of the write windows go into the FIRST read window.  The second read 
window continues to block on the open, getting nothing.

Is this documented somewhere?  This wasn't the behavior I expected out of the 
suckers.  Read blocks until somebody does a write, and write blocks until 
somebody does a read, but other writes don't block as long as there's at 
least one reader, and the second read blocks until the first goes away.  It's 
not symmetrical.  I can go back to "open /tmp/$pid, read, write, unlink 
/tmp/$pid", but it's annoying.

This behavior is posix, perhaps?  (2.4.17 kernel if that makes a difference.  
It's probably intentional, it's just weird...)

I ran into THIS problem because pipe(3) has an even STRANGER behavior.  It 
does NOT like being mixed with dup2().   Pesudo-code:

int pipes[2];

pipe(pipes)
dup2(pipes[0],0);
close(pipes[0]);

Boom: the pipe is no longer usable.  The stdin instance of it is closed too.  
Read from it you get an error.  (But if I DON'T close it, I'm leaking file 
handles, aren't I?  AAAAAAAAH!)

Sigh.  It's friday evening.  I should go do something else for a while...

Rob
