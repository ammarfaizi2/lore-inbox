Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262883AbTENV2d (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 17:28:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262884AbTENV2c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 17:28:32 -0400
Received: from iole.cs.brandeis.edu ([129.64.3.240]:645 "EHLO
	iole.cs.brandeis.edu") by vger.kernel.org with ESMTP
	id S262883AbTENV2b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 17:28:31 -0400
Date: Wed, 14 May 2003 17:41:23 -0400 (EDT)
From: Mikhail Kruk <meshko@cs.brandeis.edu>
To: <linux-kernel@vger.kernel.org>
Subject: possible open/unlink race condition?
Message-ID: <Pine.LNX.4.33.0305141727500.20287-100000@iole.cs.brandeis.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm seeing a possible race condition on 2.4.18. It seems that the 
following scenario is possible:

process 1				process 2

open(filename, O_CREATE)
 start creating file
 put an entry into the directory cache

<CONTEXT SWITCH>
					opendir()
					readdir() // returns "filename"
					unlink(filename) // success
					access(filename) // it's gone

					<CONTEXTSWITCH>
 write the directory update on disk
 result: file is resurrected but process 2 thinks it deleted it

-----------------------

The description of file creation in the process 1 is completely made up, I 
don't really know how it works and I'm only starting to look at the 
kernel, but I just would like to know if something like this is at all 
possible. I.e. is it possible that process 1 creates file, process 2 
sees that file in a directory and unlinks it, and then process 1 does 
something inside the same open call, which resurrects the file? 

It really looks like this is happening (very rarely) in an 
application I'm debugging.

please cc me, I'm not on the list

