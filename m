Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262357AbUKVUzp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262357AbUKVUzp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 15:55:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261642AbUKVUyE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 15:54:04 -0500
Received: from smtp8.wanadoo.fr ([193.252.22.23]:20886 "EHLO smtp8.wanadoo.fr")
	by vger.kernel.org with ESMTP id S262390AbUKVUw7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 15:52:59 -0500
Message-ID: <41A251A6.2030205@wanadoo.fr>
Date: Mon, 22 Nov 2004 21:52:54 +0100
From: Eric Pouech <pouech-eric@wanadoo.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.6) Gecko/20040115
X-Accept-Language: fr, en
MIME-Version: 1.0
To: Jesse Allen <the3dfxdude@gmail.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Daniel Jacobowitz <dan@debian.org>,
       Roland McGrath <roland@redhat.com>, Mike Hearn <mh@codeweavers.com>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       wine-devel <wine-devel@winehq.com>
Subject: Re: ptrace single-stepping change breaks Wine
References: <200411152253.iAFMr8JL030601@magilla.sf.frob.com> <419E42B3.8070901@wanadoo.fr> <Pine.LNX.4.58.0411191119320.2222@ppc970.osdl.org> <419E4A76.8020909@wanadoo.fr> <Pine.LNX.4.58.0411191148480.2222@ppc970.osdl.org> <419E5A88.1050701@wanadoo.fr> <20041119212327.GA8121@nevyn.them.org> <Pine.LNX.4.58.0411191330210.2222@ppc970.osdl.org> <20041120214915.GA6100@tesore.ph.cox.net>
In-Reply-To: <20041120214915.GA6100@tesore.ph.cox.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesse Allen a écrit :
> On Fri, Nov 19, 2004 at 01:53:38PM -0800, Linus Torvalds wrote:
> 
>>
>>On Fri, 19 Nov 2004, Daniel Jacobowitz wrote:
>>
>>>I'm getting the feeling that the question of whether to step into
>>>signal handlers is orthogonal to single-stepping; maybe it should be a
>>>separate ptrace operation.
>>
>>I really don't see why. If a controlling process is asking for 
>>single-stepping, then it damn well should get it. It it doesn't want to 
>>single-step through a signal handler, then it could decide to just put a 
>>breakpoint on the return point (possibly by modifying the signal handler 
>>save area).
>>
>>It's not like single-stepping into the signal handler in any way removes 
>>any information (while _not_ single-stepping into it clearly does).
>>
>>With the patch I just posted (assuming it works for people), Wine should 
>>at least have the choice. The behaviour now should be:
>>
>> - if the app sets TF on its own, it will cause a SIGTRAP which it can 
>>   catch.
>> - if the debugger sets TF with SINGLESTEP, it will single-step into a 
>>   signal handler.
>> - it the app sets TF _and_ you ptrace it, you the ptracer will see the 
>>   debug event and catch it. However, doing a "continue" at that point
>>   will remove the TF flag (and always has), the app will normally then
>>   never see the trap. You can do a "signal SIGTRAP" to actually force
>>   the trap handler to tun, but that one won't actually single-step (it's 
>>   a "continue" in all other senses).
>>
>>It sounds like the third case is what wine wants.
>>
>>		Linus
> 
> 
> 
> So an app running through wine could set TF on it's own?  It would be a 
> good idea to find out what it is doing in the first place.  There has to be
> a reason why War3 is so picky after the original change was introduced and
> a reason why the latest changes don't seem to fix it. 
> 
> I've built a kernel 2.6.10-rc2 with the new ptrace patch.  The program still
> says "please insert disc".  I haven't been able to get winedbg to tell me 
> anything useful -- the program never crashes anyways.  So I went ahead and I 
> captured a debug log.
> 
> the command:
> WINEDEBUG=+all wine war3/Warcraft\ III.exe -opengl >& war3_and_2.6.10-rc2.log
> 
> I scanned for the part right before it calls up to display the error.  I found
> that after loading advapi32.dll, the thread 000c creates a mutex and wakes up
> 000a.  Then 000c gets killed and right after that starts calling up the 
> resources for the "insert disc" message box.  I put the log up on my ftp, and 
> the interesting part in a seperate file:
> ftp://resnet.dnip.net/
> 
> Any clue on what may be happening here?  Or maybe another idea on where else to search?
> 
> 
> Jesse
> 
> 
> 
For the linux folks, here a small comparison of what happens in the working 
(old) case and in the non-working (new) case:

In both case

- Wine gets a first SIGTRAP (in it's sig_trap handler)
	+ Wine converts it into a Windows exception (w-exception in short).
	  This includes creating a context for the generic CPU registers
	+ This w-exception is sent to the w-exception handler the program
	  installed (this one can modifiy the all registers)
		o this handler touches one of the i386 debug registers
	+ as we need to update the debug registers values (and we don't do in
	  the signal handler return), this task is delegated to the Wine server
	  (our central process, which is in charge of synchronisation...)
		> the Wine server ptrace-attach:es to the process which handled
		  the SIGTRAP.
		> Wine server wait4:s on the SIGSTOP (after ptrace:attach)
		> modify (with ptrace) the debug registers
		> and resumes excution (ptrace: cont)
	+ wine terminates the sig trap handler and resumes the execution with
	  the modified basic registers (from the saved context), and the
	  modified debug registers (from the Wine server round trip)
- a second sig trap is generated
	> since the wine server is still ptrace:attached, it gets the signal.	

What differs then in both execution:
- in the working case, the sig trap handler is called on the client side, 
whereas it's never called in the non-working case. We do have a couple of 
protection (to avoid some misbehaving apps), but none of them get triggered. So 
it seems like the trap handler is not called (ugh).

A couple of notes:
- as the program tested is copy protected, and as it seems that the copy 
protection is what causes the harm, it can be interesting to know that the 
programe seems to set the TF flag (some copy protection schemes directly do an 
"int 1", but given the exception code we get, this isn't the case).
- in Windows trap handling, the TF is explictly reset before calling the windows 
exception handler (which is what Wine does, before calling the window exception 
handler). Of course the handler can set it back if it wants to continue single 
stepping.

HTH
A+

