Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262829AbRFCIIC>; Sun, 3 Jun 2001 04:08:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262831AbRFCIHw>; Sun, 3 Jun 2001 04:07:52 -0400
Received: from csl.Stanford.EDU ([171.64.66.149]:61938 "EHLO csl.Stanford.EDU")
	by vger.kernel.org with ESMTP id <S262829AbRFCIHj>;
	Sun, 3 Jun 2001 04:07:39 -0400
From: Dawson Engler <engler@csl.Stanford.EDU>
Message-Id: <200106030807.BAA02597@csl.Stanford.EDU>
Subject: [CHECKER] security rules?  (and 2.4.5-ac4 security bug)
To: linux-kernel@vger.kernel.org
Date: Sun, 3 Jun 2001 01:07:37 -0700 (PDT)
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

Enclosed is a potential security hole in 2.4.5-ac where an integer from
user space is used as a length argument to copy_to_user.

Additionally, do people have suggestions for good security rules?
We're looking to expand our security checkers.  Right now we just have
checkers that warn when:

	1. user pointers are dereferenced

	2. an integer from user space is used as a length argument to
	   copy*user or as an array index. (this is getting extended
	   to include data from network packets)

	3. user input can trigger a known bug (e.g., the failed release of
	a lock, or a copy_*_user call with interrupts disabled).

more preliminary:
	(4) a checker that derives when you're supposed to
	    do an capable? call and warns when you don't.

	(5) checkers to find typical format string bugs.

I'm sure there are a huge set of security holes that are not covered by
these sorts of checks, so if anyone has suggestions, please let us know.

Dawson

PS Someone from world.std.com (I believe) sent a nice rule yesterday,
   but I accidently deleted the message --- could you please resend?


[BUG]
/u2/engler/mc/oses/linux/2.4.5-ac4/drivers/char/random.c:1813:uuid_strategy: ERROR:RANGE:1809:1813: Using user length "len" as argument to "copy_to_user" [type=LOCAL] set by 'get_user':1813

                uuid[8] = 0;
        }
        if (uuid[8] == 0)
                generate_random_uuid(uuid);

Start --->
        get_user(len, oldlenp);
        if (len) {
                if (len > 16)
                        len = 16;
Error --->
                if (copy_to_user(oldval, table->data, len))
                        return -EFAULT;
                if (put_user(len, oldlenp))
                        return -EFAULT;

