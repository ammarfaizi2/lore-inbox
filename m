Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262316AbSI1UFS>; Sat, 28 Sep 2002 16:05:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262317AbSI1UFS>; Sat, 28 Sep 2002 16:05:18 -0400
Received: from isis.cs3-inc.com ([207.224.119.73]:41974 "EHLO isis.cs3-inc.com")
	by vger.kernel.org with ESMTP id <S262316AbSI1UFS>;
	Sat, 28 Sep 2002 16:05:18 -0400
Date: Sat, 28 Sep 2002 13:10:28 -0700
Message-Id: <200209282010.g8SKASL01208@isis.cs3-inc.com>
From: don-temp5298413@isis.cs3-inc.com (Don Cohen)
To: linux-kernel@vger.kernel.org
Subject: reading /proc files larger than one buffer
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


If you follow the directions in Documentation/DocBook/procfs-guide.tmpl
then your file read will not work correctly unless the whole file is
read in one call.

After examining (and experimenting with) fs/proc/generic.c I now see
what you have to do: in addition to writing bytes in the page
parameter, setting eof as appropriate and returning the number of
bytes written, you also need to do:
 *start = page;
At minimum the documentation should be corrected.

Actually I think this is a bug in proc_file_read.
The problem seems to be in this code, executed after the read function:

               if (!start) {
                        /*
                         * For proc files that are less than 4k
                         */
                        start = page + *ppos;
                        n -= *ppos;
                        if (n <= 0)
                                break;
                        if (n > count)
                                n = count;
                }
 
Can anyone explain what it's supposed to do?
What does it have to do with files < 4k ?

The addition of "*start = page;" both sets start to the correct value
and avoids executing the problematic code above.
[Note: The "start" in your read function is actually the address of
the "start" in proc_file_read.]

Therefore I think that code should be

               if (!start) start=page;

The current code normally works for the first read because *ppos is 0.
Otherwise:
- start is given the wrong value (should be page)
- n is the number of bytes read, and it makes no sense to reduce that
 by ppos, which is the file position at which you were supposed to
 start reading.  

The behavior I saw was that on the second buffer count and ppos were 
both 512 (asked to read bytes 512-1023).  My function returned 512,
so n was set to 0, which was then interpreted as eof.

Please cc me on replies.
