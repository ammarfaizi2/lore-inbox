Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129074AbRBBN3K>; Fri, 2 Feb 2001 08:29:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129158AbRBBN2u>; Fri, 2 Feb 2001 08:28:50 -0500
Received: from dell-pe2450-1.cambridge.redhat.com ([172.16.18.1]:54532 "HELO
	executor.cambridge.redhat.com") by vger.kernel.org with SMTP
	id <S129074AbRBBN2i>; Fri, 2 Feb 2001 08:28:38 -0500
To: aviro@redhat.com
Cc: linux-kernel@vger.kernel.org, dhowells@redhat.com
Subject: [BUG] directory renaming/removal
Date: Fri, 02 Feb 2001 13:28:28 +0000
Message-ID: <4260.981120508@warthog.cambridge.redhat.com>
From: David Howells <dhowells@cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Run the following script (It's been tried on linux-2.2.x and linux-2.4.x):

#!/bin/sh
cd /tmp
mkdir x
cd x
mkdir x y z
strace -etrace=rename,mkdir,rmdir,chmod mv x z
echo ---------
chmod -w y
strace -etrace=rename,mkdir,rmdir,chmod mv y z

The output:

rename("x", "z/x")                      = 0
---------
rename("y", "z/y")                      = -1 EACCES (Permission denied)
mkdir("z/y", 040755)                    = 0
chmod("z/y", 040555)                    = 0
rmdir("y")                              = 0

You'll notice the following:

 (1) Linux can't rename directories that are marked as read-only. This is
     strange because the directories actually being modified _do_ have write
     permission.

 (2) You can _remove_ a read-only directory.

David
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
