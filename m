Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268348AbRGWVEP>; Mon, 23 Jul 2001 17:04:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268344AbRGWVEG>; Mon, 23 Jul 2001 17:04:06 -0400
Received: from smtprt15.wanadoo.fr ([193.252.19.210]:34701 "EHLO
	smtprt15.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S268348AbRGWVDy>; Mon, 23 Jul 2001 17:03:54 -0400
Message-ID: <3B5C91DA.3C8073AC@wanadoo.fr>
Date: Mon, 23 Jul 2001 23:06:34 +0200
From: Jerome de Vivie <jerome.de-vivie@wanadoo.fr>
Organization: CoolSite
X-Mailer: Mozilla 4.74 [fr] (X11; U; Linux 2.4.4-sb i686)
X-Accept-Language: French, fr, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, linux-fsdev@vger.kernel.org,
        martizab@libertsurf.fr, rusty@rustcorp.com.au
Subject: Yet another linux filesytem: with version control
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Hi all,

Handling multiples versions is a tough challenge (...even in the linux
kernel). Working under software configuration management (SCM) helps
but with some overhead; and it works only if everybody support it.

>From CVS to ClearCase, i haven't seen any easy tool. I feel a real 
need to handle SCM simply.

The multiple version filesystem (mvfs) of ClearCase gives a
transparent acces to the data. I found this feature cool, but the
overall system is too complex. I would like to write an extension
module for the linux kernel to handle version control in a simply way.


Here's the main features:

-no check-out/check-in 
-labelization 
-private copy
-transparent acces to data 
-select configuration with a single environment variable. 
-mix of normal files (with the base FS) and, files which are managed 
under version control (C-files) in a same filesystem.

Here's how i see it works:

When a C-file is created, the label "init" is put onto.  The first
write on a C-file create a private copy for the user who run the
process. This C-file is added to a "User File List" (UFL). This
private copy is now selected by the FS in place of version "init". 
Each user can start his own private copy by writting into a C-file.

When a developper has reach a step and, would like to share his work;
he creates a new label. This label will be put on every private copy
listed in the UFL and, the UFL is zeroed. Thoses new versions
are now public. They are viewed by setting $CONFIGURATION to the new
label. New developpement can be start from this label.

The label "init" is predefined. Labels will be organized in a tree 
and, the structure will look like this:

struct label {
       int id;
       char [] name;
       struct label * parent;
}

When we access a C-file with a "read" or a "write", the extension
module select one version with the following rules:

First, if the C-file is into the UFL, we have a private copy to
select. Else, we choose the version labeled by "$CONFIGURATION". If
such version does not exist, we search the version marked by the
nearest "parent" label (at least, label "init" match).

In kernel side, we need to manage the following structes:
-a tree of versions for each C-file.
-a tree of labels.
-a UFL list for each developpers.


In userland, we need:
-a "mklabel" tool.
-use a "CONFIGURATION" environment variable.
-use existing tool for "merge" operations.


If my design match your needs and, if there is enough feedback; i will
start this project. As i'm not a super kernel hacker, i need your help.

Any volunters are welcome !

j.

-- 
Jerome de Vivie 	jerome . de - vivie @ wanadoo . fr
