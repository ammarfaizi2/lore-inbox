Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316601AbSGBDj5>; Mon, 1 Jul 2002 23:39:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316604AbSGBDj4>; Mon, 1 Jul 2002 23:39:56 -0400
Received: from rj.SGI.COM ([192.82.208.96]:50123 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S316601AbSGBDjz>;
	Mon, 1 Jul 2002 23:39:55 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Subject: Re: RE2: [OKS] Module removal 
In-reply-to: Your message of "Tue, 02 Jul 2002 00:11:52 -0300."
             <20020702001152.D2295@almesberger.net> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 02 Jul 2002 13:42:16 +1000
Message-ID: <31775.1025581336@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 Jul 2002 00:11:52 -0300, 
Werner Almesberger <wa@almesberger.net> wrote:
>Keith Owens wrote:
>> This is just one symptom of the overall problem, which is module code
>> that adjusts its use count by executing code that belongs to the
>> module.  The same problem exists on entry to a module function, the
>> module can be removed before MOD_INC_USE_COUNT is reached.
>
>Ah yes, now I remember, thanks. I filed that under "improper reference
>tracking". After all, why would anybody hold an uncounted reference in
>the first place ?

All functions passed to registration routines by modules are uncounted
references.  A module is loaded, registers its operations and exits
from the cleanup routine.  At that point its use count is 0, even
though it there are references to the module from tables outside the
module.

When the open routine (or its equivalent) is called, then the use count
is incremented from within the module.  The executing code between

  if (ops->open)
  	ops->open();

and MOD_INC_USE_COUNT in the module's open routine is racy, there is no
lock that prevents the module being removed while the start of the open
routine is being executed.

Incrementing the use count at registration time is no good, it stops
the module being unloaded.  Operations are deregistered at rmmod time.
Setting the use count at registration prevents rmmod from removing the
module, so you cannot deregister the operations.  Catch 22.

Module unload is not racy on UP without preempt.  It is racy on SMP or
with preempt.  It used to be safe on SMP because almost everything was
under the BKL, but that protection no longer exists.

