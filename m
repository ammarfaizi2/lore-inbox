Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135471AbRDRXYR>; Wed, 18 Apr 2001 19:24:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135472AbRDRXYI>; Wed, 18 Apr 2001 19:24:08 -0400
Received: from ganesh.phy.duke.edu ([152.3.183.52]:65296 "EHLO
	ganesh.phy.duke.edu") by vger.kernel.org with ESMTP
	id <S135471AbRDRXXz>; Wed, 18 Apr 2001 19:23:55 -0400
Date: Wed, 18 Apr 2001 19:23:52 -0400 (EDT)
From: "Robert G. Brown" <rgb@phy.duke.edu>
To: <linux-kernel@vger.kernel.org>
Subject: FPE's
Message-ID: <Pine.LNX.4.30.0104181920140.32745-100000@ganesh.phy.duke.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Kernel Experts,

A question recently arose on the beowulf list about determining the
largest possible float or double (or the smallest) that would not
overflow (or underflow) on a general system, which on the beowulf list
is not unreasonably a general linux/gnu system.

I suggested that one should be able to trap the FPE that is supposed to
occur on an overflow and do a binary search to find the boundary value
where it just doesn't in a reasonable amount of time.  The standard glib
documentation suggests that I should be able to do this as well.

The following code fragment looks like it "should" force an exception,
and on a BSD or GNU system (according to the glib manual) there should
be an extra argument one can define for the handler that indicates the
type of the exception as well (with a cast required to define the signal
handler without complaint).

However, it doesn't work.  Rather, the handler works fine -- if I send
the process kill -FPE PID it dies very nicely after printing out the
message from the handler.  However, nothing I have been able to put into
the force_exception program actually forces an exception -- I just print
out d = inf or nan depending on whether I include e.g. the sqrt of -1.

This leads to several questions, which I wouldn't ask here if I could
find answers elsewhere and which do perhaps depend on the kernel.

  a) Is there any FPE or otherwise trappable event associated with
overflow, underflow or division by zero?  There is a whole list of
entities defined in man sigaction which appear to be particular
exceptions that would be placed into si_code if I used the sa_sigaction
method of installing the signal, but of course this cannot work if
overflow etc. don't cause an FPE to be raised. I did try.

  b) If not, is there any related methodology that could be used to
dynamically determine the overflow boundary?  I tried setting double
infinity=1.0/0.0; (which is crazy but works) and then testing a loop
that doubles d each pass and compares it to infinity (saving the
previous result) but d goes itself to inf without ever satisfying the
equality or even an inequality -- apparently there are multiple values
of "infinity" or the conditional statement doesn't know how to resolve
"d == infinity" when both print as inf and are generated from overflow
values.

  c) Am I being stupid.  I'm (as always:-) open minded about this, and
eager to learn...

   rgb

-- 
Robert G. Brown	                       http://www.phy.duke.edu/~rgb/
Duke University Dept. of Physics, Box 90305
Durham, N.C. 27708-0305
Phone: 1-919-660-2567  Fax: 919-660-2525     email:rgb@phy.duke.edu




/*
 * Code fragment which should force a floating point exception and
 * handle it in a private handler.
 */

void fpe(int signum,int sigtype){

 printf("FPE found of type %d\n",sigtype);
 exit(0);

}

void force_exception()
{

 struct sigaction newaction,oldaction;
 double d;

 /* Install a new handler. */
 newaction.sa_handler = fpe;
 sigemptyset(&newaction.sa_mask);
 newaction.sa_flags = 0;

 /* Get the old handler... */
 sigaction(SIGFPE,NULL,&oldaction);
 if(oldaction.sa_handler != SIG_IGN)
   sigaction(SIGFPE,&newaction,NULL);

 /* Force an FPE */
 d = sqrt(-1.0);
 d = sin(sqrt(-1.0));
 d = d/0.0;
 printf("SHOULD have died before it gets here... d = %20.15e\n",d);
 while(1){}

}


