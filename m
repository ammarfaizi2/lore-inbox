Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266473AbTBPMUl>; Sun, 16 Feb 2003 07:20:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266540AbTBPMUl>; Sun, 16 Feb 2003 07:20:41 -0500
Received: from zodiac.mimuw.edu.pl ([193.0.96.128]:2249 "EHLO
	students.mimuw.edu.pl") by vger.kernel.org with ESMTP
	id <S266473AbTBPMUk>; Sun, 16 Feb 2003 07:20:40 -0500
Date: Sun, 16 Feb 2003 13:30:34 +0100 (CET)
From: Tomasz Malesinski <tm201069@students.mimuw.edu.pl>
X-X-Sender: tm201069@zodiac.mimuw.edu.pl
To: linux-kernel@vger.kernel.org
Cc: Tomasz Malesinski <tm201069@students.mimuw.edu.pl>
Subject: Floppy driver doesn't stop on errors
Message-ID: <Pine.LNX.4.44.0302161324550.1520-100000@zodiac.mimuw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am using 2.5.56 kernel. I haven't tested it with newer versions, but I 
haven't found any changes in sources referencing this.

The problem is that when reading a floppy disk with an error the kernel
tries to read the bad sector forever and I found no other way to stop it
than a reboot. It happens because when the floppy driver tries to read a
track with an error it reads all sectors until the error, writes the
number of them to current_count_sectors and passes that number to
end_that_request_first. That's ok, but if the buffer isn't full the next
read starts at the bad sector, no correct sectors are read,
current_count_sectors becomes 0 and the buffer state does not change.

I am not sure what a proper way to fix this is. I changed the beginning of
end_request routine in floppy.c from:

static inline void end_request(struct request *req, int uptodate)
{
	if (end_that_request_first(req, uptodate, current_count_sectors))
		return;

to:

static inline void end_request(struct request *req, int uptodate)
{
	if (end_that_request_first(req, uptodate,
	    (!current_count_sectors && !uptodate) ? 1 : current_count_sectors))
		return;

It works for me, but probably it would be better to pass some other value
in case of an error, for example the current bio size in sectors.

Tomasz Malesinski

