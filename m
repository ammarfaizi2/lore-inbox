Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264340AbRFDRxg>; Mon, 4 Jun 2001 13:53:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263755AbRFDRlx>; Mon, 4 Jun 2001 13:41:53 -0400
Received: from merlin.giref.ulaval.ca ([132.203.7.100]:64942 "HELO
	merlin.giref.ulaval.ca") by vger.kernel.org with SMTP
	id <S264345AbRFDRfh>; Mon, 4 Jun 2001 13:35:37 -0400
Message-ID: <3B1BC6BF.8098111A@giref.ulaval.ca>
Date: Mon, 04 Jun 2001 13:34:55 -0400
From: Mihai Moise <mmoise@giref.ulaval.ca>
Organization: GIREF
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: semaphores and noatomic flag
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I write this to discuss the reasons why the semop system call should
have an IPC_NOATOMIC flag.

Suppose we have two processes, called client and server, which
communicate through a shared memory segment and two semaphores, and need
to synchonize their activities so that they don't operate simultaneously
except at startup.

The server would do,

down(smephore 0)

to wait for a message from the client. When the client needs the server
to execute, it would,

up(semaphore 0)		/* wake up server */
down(semaphore 1)	/* put itself to sleep */

after the server has completed its portion of the task, it would,

up(semaphore 1)		/* wake up client */
down(semaphore 0)	/* put iself to sleep */

The problem is that the two system calls make the whole process twice as
slow as it needs to be, and they are both needed because the semop
system call is implemented in an atomic manner. If the semop system call
had an IPC_NOATOMIC flag, then the each process would only have to do
one call,

semop(up semaphore 0 & down semaphore 1, IPC_NOATOMIC)

which would be interpreted in the kernel as the sequence of two system
calls I have written previously.

I want to know what other people think about this idea.

Mihai
