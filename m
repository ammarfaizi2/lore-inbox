Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262805AbSKDWPq>; Mon, 4 Nov 2002 17:15:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262807AbSKDWPq>; Mon, 4 Nov 2002 17:15:46 -0500
Received: from mailgw.cvut.cz ([147.32.3.235]:3267 "EHLO mailgw.cvut.cz")
	by vger.kernel.org with ESMTP id <S262805AbSKDWPp>;
	Mon, 4 Nov 2002 17:15:45 -0500
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: linux-kernel@vger.kernel.org
Date: Mon, 4 Nov 2002 23:21:58 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Floppy disk change detection in 2.4.19 and 2.5.45...
X-mailer: Pegasus Mail v3.50
Message-ID: <6962D7F5148@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
  when floppy driver changes in 2.3.99 happened, I was told that
if /dev/fd0 is opened with O_EXCL | O_SYNC, read()/write() after
disk change will fail with error, and so app is notified about change.

But today it was pointed to me that this does not work anymore: both
2.4.19 and 2.5.45 do not report disk change when used this way (2.4.5
does). When I use O_EXCL | O_NDELAY, I can detect that disk change 
happened since last close, but subsequent disk changes are not reported 
to the app, so it is unusable too...

I stared at floppy.c code (in 2.5.45) for an hour, but I cannot find what's
proper way to do that: after disk change I need that read or write fails
(preferred) or that I can call some ioctl() before read/write and this
ioctl will tell me that disk change happened (I did not found such call,
sorry).
                                     Thanks,
                                            Petr Vandrovec
                                            vandrove@vc.cvut.cz
                                                                                        

#include <stdio.h>
#include <fcntl.h>
#include <unistd.h>
#include <linux/fd.h>
#include <sys/ioctl.h>

int main(void) {
    int fd;
    char b[512];
    int r;

    fd = open("/dev/fd0", O_EXCL | O_SYNC | O_RDWR);
    if (fd == -1) {
        perror("Open");
        return 100;
    }
    printf("FD opened, %u\n", fd);
    r = ioctl(fd, FDCLRPRM, 0);
    if (r) {
        perror("Error clearing disk change notification");
    }
    r = read(fd, b, sizeof(b));
    if (r == -1) {
        perror("Read");
        return 99;
    }
    printf("%u bytes was read\n", r);
    getpass("Now replace disk and hit ENTER");
    r = read(fd, b, sizeof(b));
    if (r == -1) {
        perror("Read after disk change failed, ok");
        return 0;
    }
    printf("%u bytes was read, your kernel and/or drive is buggy, or you did not swap diskette\n", r);
    close(fd);
    return 98;
}
