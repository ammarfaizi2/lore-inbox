Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131462AbRAHU5P>; Mon, 8 Jan 2001 15:57:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131324AbRAHU5F>; Mon, 8 Jan 2001 15:57:05 -0500
Received: from hera.cwi.nl ([192.16.191.1]:48557 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S129387AbRAHU4w>;
	Mon, 8 Jan 2001 15:56:52 -0500
Date: Mon, 8 Jan 2001 21:56:18 +0100 (MET)
From: Andries.Brouwer@cwi.nl
Message-Id: <UTC200101082056.VAA147872.aeb@texel.cwi.nl>
To: andrea@suse.de, linux-kernel@vger.kernel.org
Subject: Re: `rmdir .` doesn't work in 2.4
Cc: viro@math.psu.edu
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> why `rmdir .` is been deprecated in 2.4.x?

> `rmdir .` makes perfect sense, the cwd dentry remains pinned

You think that it fails with EBUSY. That would be allowed but not required:

[EBUSY]: The directory to be removed is currently in use by
         the system or some process and the implementation
         considers this to be an error.

Here we are free to consider this "in use" an error or not.
But in fact it fails with EINVAL, and

[EINVAL]: The path argument contains a last component that is dot.

(Quoted from the last Austin draft.)
Thus, for POSIX compliance we do need the current behaviour.

Also logically rmdir(".") is a doubtful operation.
Indeed, rmdir("P/D") does roughly the following:
(i) check that P/D is a directory
(ii) check that P/D does not have entries other than . and ..
(iii) delete the names . and .. from P/D
(iv) delete the name D from P

You see that rmdir("P/.") would have to do something other than (iv),
namely deleting something from the parent directory of P.
In cases where hard links to directories are permitted,
it is not even clear we can talk about "the parent directory".
So, I do not think that "rmdir ." makes perfect sense.

Andries

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
