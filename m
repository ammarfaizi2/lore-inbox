Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271240AbTHHG2q (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Aug 2003 02:28:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271255AbTHHG2q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Aug 2003 02:28:46 -0400
Received: from magic-mail.adaptec.com ([208.236.45.100]:1951 "EHLO
	magic.adaptec.com") by vger.kernel.org with ESMTP id S271240AbTHHG2o
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Aug 2003 02:28:44 -0400
Date: Thu, 7 Aug 2003 23:59:00 +0530 (IST)
From: Nagendra Singh Tomar <nagendra_tomar@adaptec.com>
X-X-Sender: tomar@localhost.localdomain
Reply-To: nagendra_tomar@adaptec.com
To: Paul.Russell@rustcorp.com.au
cc: linux-kernel@vger.kernel.org,
       "Tomar, Nagendra" <nagendra_tomar@adaptec.com>
Subject: BUG in fs/proc/generic.c:proc_file_read
Message-ID: <Pine.LNX.4.44.0308072346020.3811-100000@localhost.localdomain>
Organization: Adaptec
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In short:
The hack used to be able to read proc files larger than 4k, breaks if the 
caller does lseek() after read()

Detailed:
I am providing a proc read interface to one of my proc files by using the 
given hack symantics in which every call to read_proc() writes the data 
starting at the begining of the page but sets "*start" artificially to 
indicate how many fields have been read. proc_file_read then correctly 
adjusts *ppos to signify the artificial position inside the proc file 
where the read pointer points. It is *artificial* beacuse it is not the 
byte offset but some other offset which only read_proc understands. Next 
time around when read_proc gets the *ppos to start reading from it knows 
how to calculate the exxat byte offset from the *artificial* *ppos 
provided.
This works fine with cat which simply calls read(). The "more" command 
though has the following call pattern

read(fd,buf,4096) = X
lseek(fd,X,SEEK_SET);

-- lseek modified file->f_pos to the byte offset value, which disturbed 
read_proc ---

read(fd,buf,4096) = 0;


the effect is that more never gives me data more than 4096 bytes worth.

My Question is. Is it a known problem ? 


Thanx 
tomar

