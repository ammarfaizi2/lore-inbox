Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261654AbVFQXBu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261654AbVFQXBu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Jun 2005 19:01:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261708AbVFQXBu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Jun 2005 19:01:50 -0400
Received: from web30702.mail.mud.yahoo.com ([68.142.200.135]:56974 "HELO
	web30702.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S261654AbVFQXBf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Jun 2005 19:01:35 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=TB+ht3D2QFVyzfNextm9OGhS/f+8QrNJv316UkG8ZyFjW5scNiWn28Oh96muL/JqcYNNmqBRSEuHff5entuY809FW9APDjiKKlOgompV+oEg9IIN6X4Xcq/m+gI+zVJlb6mdl4dYIKjU0yqgGi8Kie/UeWq4cucX2fyxZnC5/kM=  ;
Message-ID: <20050617230130.59874.qmail@web30702.mail.mud.yahoo.com>
Date: Fri, 17 Jun 2005 16:01:30 -0700 (PDT)
From: <spaminos-ker@yahoo.com>
Reply-To: spaminos-ker@yahoo.com
Subject: Re: cfq misbehaving on 2.6.11-1.14_FC3
To: Jens Axboe <axboe@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20050617141039.GL6957@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- Jens Axboe <axboe@suse.de> wrote:
> This doesn't look good (or expected) at all. In the initial posting you
> mention this being an ide driver - I want to make sure if it's hda or
> sata driven (eg sda or similar)?

This is a regular IDE drive (a WDC WD800JB), no SATA, using hda

I didn't mention it before, but this is on a AMD8111 board.

> 
> I'll try and reproduce (and fix) your problem.

I don't know how all this works, but would there be a way to slow down the
offending writer by not allowing too many pending write requests per process?
Is there a tunable for the size of the write queue for a given device?
Reducing it will reduce the throughput, but the latency as well.

Of course, there has to be a way to get this to work right.

To go back to high latencies, maybe a different problem (but at least closely
related):

If I start in the background the command
dd if=/dev/zero of=/tmp/somefile2 bs=1024

and then run my test program in a loop, with
while true ; do time ./io 1; sleep 1s ; done

I get:

cfq: 47,33,27,48,32,29,26,49,25,47 -> 36.3 avg
deadline: 32,28,52,33,35,29,49,39,40,33 -> 37 avg
noop: 62,47,57,39,59,44,56,49,57,47 -> 51.7 avg

Now, cfq doesn't behave worst than the others, like expected (now, why it
behaved worst with the real daemons, I don't know).
Still > 30 seconds has to be improved for cfq.

the test program being:

#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>

int main(int argc, char **argv) {
        int fd,bytes;

        fd = open("/tmp/somefile", O_WRONLY | O_CREAT | O_CREAT, S_IRWXU);
        if (fd < 0) {
                perror("Could not open file");
                return 1;
        }
        bytes = write(fd, &fd, sizeof(fd));
        if (bytes < sizeof(fd)) {
                perror("Could not write");
                return 2;
        }
        if (argc != 1) {
                fsync(fd);
        }
        close(fd);
        return 0;
}

