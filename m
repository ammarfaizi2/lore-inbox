Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261856AbUCNSTT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Mar 2004 13:19:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261935AbUCNSTT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Mar 2004 13:19:19 -0500
Received: from dbl.q-ag.de ([213.172.117.3]:54168 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S261856AbUCNSTP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Mar 2004 13:19:15 -0500
Message-ID: <4054A213.6010402@colorfullife.com>
Date: Sun, 14 Mar 2004 19:18:59 +0100
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.4.1) Gecko/20031114
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
CC: linux-kernel@vger.kernel.org, Armin Schindler <aml@melware.de>
Subject: Re: [PATCH 2.4] sys_select() return error on bad file
Content-Type: multipart/mixed;
 boundary="------------010604040702030409000803"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010604040702030409000803
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Marcelo wrote:

>> 
>> Anyway, I don't see how your proposal would do better performance?
>> My patch just adds a new variable on the stack, which should not make any
>> difference in performance. And later, it is the same if the new or another
>> variable gets changed or checked.
>
>Curiosity: Does SuS/POSIX define behaviour for "all fds are closed" ? 
>  
>
I'd interpret SuS that a closed fd is ready for reading and writing:
 From the select page:
<<<
A descriptor shall be considered ready for reading when a call to an 
input function with O_NONBLOCK clear would not block, whether or not the 
function would transfer data successfully. (The function might return 
data, an end-of-file indication, or an error other than one indicating 
that it is blocked, and in each of these cases the descriptor shall be 
considered ready for reading.)
<<<
read(fd,,) will return immediately with EBADF, thus the fd is ready.

But that's a grey area, especially if you close the fd during the select 
call. For example HP UX just kills the current process if an fd that is 
polled is closed by overwriting it with dup2. I didn't test select, but 
I'd expect a similar behavior.

Armin: did you compare the Linux behavior with other unices? Are there 
other unices that return EBADF for select() if all fds are closed?

Attached is an untested proposal, against 2.6, but I'm not sure if it's 
really a good idea to change the current code - it might break existing 
apps.

--
    Manfred

--------------010604040702030409000803
Content-Type: text/plain;
 name="patch-select-2.6"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-select-2.6"

--- 2.6/fs/select.c	2004-03-14 14:28:28.000000000 +0100
+++ build-2.6/fs/select.c	2004-03-14 19:08:57.000000000 +0100
@@ -223,25 +223,25 @@
 					break;
 				if (!(bit & all_bits))
 					continue;
+				mask = DEFAULT_POLLMASK;
 				file = fget(i);
 				if (file) {
 					f_op = file->f_op;
-					mask = DEFAULT_POLLMASK;
 					if (f_op && f_op->poll)
 						mask = (*f_op->poll)(file, retval ? NULL : wait);
 					fput(file);
-					if ((mask & POLLIN_SET) && (in & bit)) {
-						res_in |= bit;
-						retval++;
-					}
-					if ((mask & POLLOUT_SET) && (out & bit)) {
-						res_out |= bit;
-						retval++;
-					}
-					if ((mask & POLLEX_SET) && (ex & bit)) {
-						res_ex |= bit;
-						retval++;
-					}
+				}
+				if ((mask & POLLIN_SET) && (in & bit)) {
+					res_in |= bit;
+					retval++;
+				}
+				if ((mask & POLLOUT_SET) && (out & bit)) {
+					res_out |= bit;
+					retval++;
+				}
+				if ((mask & POLLEX_SET) && (ex & bit)) {
+					res_ex |= bit;
+					retval++;
 				}
 			}
 			if (res_in)

--------------010604040702030409000803--

