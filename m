Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262031AbVBAO5D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262031AbVBAO5D (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Feb 2005 09:57:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262026AbVBAOzu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Feb 2005 09:55:50 -0500
Received: from adsl-67-64-210-234.dsl.stlsmo.swbell.net ([67.64.210.234]:55711
	"EHLO SpacedOut.fries.net") by vger.kernel.org with ESMTP
	id S262031AbVBAOxN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Feb 2005 09:53:13 -0500
Date: Tue, 1 Feb 2005 08:52:15 -0600
From: David Fries <dfries@mail.win.org>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Linus Torvalds <torvalds@osdl.org>, trivial@rustcorp.com.au,
       linux-kernel@vger.kernel.org
Subject: [PATCH] Linux joydev joystick disconnect patch 2.6.11-rc2
Message-ID: <20050201145215.GA29942@spacedout.fries.net>
References: <20041123212813.GA3196@spacedout.fries.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Q68bSM7Ycu6FN28Q"
Content-Disposition: inline
In-Reply-To: <20041123212813.GA3196@spacedout.fries.net>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Q68bSM7Ycu6FN28Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Currently a blocking read, select, or poll call will not return if a
joystick device is unplugged.  This patch allows them to return.

This patch adds a wake_up_interruptible call to the joydev_disconnect
to interrupt both a blocking read and a blocking poll call.  The read
routine was already setup to handle this situation, just nothing was
waking it up.  The poll routine required only minimal changes to
report the error condition.  It is important to find out when the
joystick has been disconnected instead of blocking forever.

I tested it with a USB joystick, or rather I keep on getting the
following messages and my application needed to know when the joystick
was removed to close the port and re-open it when the USB system has
completed rediscovering it.

hub 4-0:1.0: port 1 enable change, status 00000101
hub 4-0:1.0: port 1 disabled by hub (EMI?), re-enabling...
hub 4-0:1.0: port 1, status 0101, change 0002, 12 Mb/s
usb 4-1: USB disconnect, address 39
usb 4-1: usb_disable_device nuking all URBs

I can reliably enough reproduce the problem by standing up as the
static on my cloth chair followed by a discharge to the chair is
enough to cause the joystick to be disabled by the USB HUB even if I'm
only touching the chair and floor!  The kernel then removes the old
joystick and redetects it as a new joystick.

I've also included a test program to verify that a blocking select,
poll, and read call will return if the joystick is unplugged.

-- 
David Fries <dfries@mail.win.org>
http://fries.net/~david/pgpkey.txt



Signed-off-by: David Fries <dfries@mail.win.org>

--- drivers/input/joydev.c.orig	Tue Feb  1 08:39:52 2005
+++ drivers/input/joydev.c	Tue Feb  1 08:40:15 2005
@@ -279,11 +279,14 @@ static ssize_t joydev_read(struct file *
 /* No kernel lock - fine */
 static unsigned int joydev_poll(struct file *file, poll_table *wait)
 {
+	int mask = 0;
 	struct joydev_list *list = file->private_data;
 	poll_wait(file, &list->joydev->wait, wait);
-	if (list->head != list->tail || list->startup < list->joydev->nabs + list->joydev->nkey)
-		return POLLIN | POLLRDNORM;
-	return 0;
+	if(!list->joydev->exist)
+		mask |= POLLERR;
+	if(list->head != list->tail || list->startup < list->joydev->nabs + list->joydev->nkey)
+		mask |= POLLIN | POLLRDNORM;
+	return mask;
 }
 
 static int joydev_ioctl(struct inode *inode, struct file *file, unsigned int cmd, unsigned long arg)
@@ -469,9 +472,14 @@ static void joydev_disconnect(struct inp
 	joydev->exist = 0;
 
 	if (joydev->open)
+	{
 		input_close_device(handle);
+		wake_up_interruptible(&joydev->wait);
+	}
 	else
+	{
 		joydev_free(joydev);
+	}
 }
 
 static struct input_device_id joydev_blacklist[] = {

--Q68bSM7Ycu6FN28Q
Content-Type: text/x-csrc; charset=us-ascii
Content-Disposition: attachment; filename="joystick_select.c"

#include <sys/poll.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <errno.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <linux/joystick.h>
#include <sys/time.h>
#include <sys/types.h>
#include <unistd.h>

//#define UFDS_COUNT 10
#define UFDS_COUNT 1

void select_call(const char *device)
{
	int result, fd;
	fd_set tmpfds, readfds, writefds, exceptfds;

	fd = open(device, O_RDONLY | O_NONBLOCK);
	if(fd == -1)
	{
		fprintf(stderr, "Error opening %s: %s\n",
			device, strerror(errno));
		exit(1);
	}

	FD_ZERO(&tmpfds);
	FD_SET(fd, &tmpfds);
	for(;;)
	{
		writefds = exceptfds = readfds = tmpfds;
		result = select(fd+1, &readfds, &writefds, &exceptfds, NULL);
		if(result == -1)
		{
			perror("Select error");
			exit(1);
		}
		if(FD_ISSET(fd, &readfds))
		{
			struct js_event event;
			int size;
			printf("%s readable\n", __FUNCTION__);
			size = read(fd, &event, sizeof(event));
			if(size == -1)
			{
				fprintf(stderr, "%s Error reading data\n",
					__FUNCTION__);
				if(errno == ENODEV)
					exit(1);
			}
		}
		if(FD_ISSET(fd, &writefds))
		{
			printf("%s writable\n", __FUNCTION__);
		}
		if(FD_ISSET(fd, &exceptfds))
		{
			printf("%s exception\n", __FUNCTION__);
			break;
		}
	}
}

void poll_call(const char *device)
{
	int i, result, fd;
	struct pollfd ufds[UFDS_COUNT];
	fd = open(device, O_RDONLY | O_NONBLOCK);
	if(fd == -1)
	{
		fprintf(stderr, "Error opening %s: %s\n",
			device, strerror(errno));
		exit(1);
	}
	for(i=0; i<UFDS_COUNT; i++)
	{
		ufds[i].fd = fd;
		ufds[i].events = POLLIN | POLLPRI | POLLOUT | POLLERR |
			POLLHUP | POLLNVAL;
		ufds[i].revents = 0;
	}
	for(;;)
	{
		result = poll(ufds, UFDS_COUNT, -1);
		if(result == -1)
		{
			perror("poll error");
			exit(1);
		}
		for(i=0; i<result; i++)
		{
			printf("poll %d, ", i);
			if(ufds[i].revents & POLLIN ||
				ufds[i].revents & POLLERR)
			{
				struct js_event event;
				int size;
				if(ufds[i].revents & POLLIN)
					printf("POLLIN There is data to read");
				else if(ufds[i].revents & POLLERR)
					printf("POLLERR Error condition");
				size = read(fd, &event, sizeof(event));
				if(size == -1)
				{
					fprintf(stderr,
						"%s Error reading data\n",
						__FUNCTION__);
					if(errno == ENODEV)
						exit(1);
				}
			}
			if(ufds[i].revents & POLLPRI)
				printf("POLLPRI There is urgent data to read");
			if(ufds[i].revents & POLLOUT)
				printf("POLLOUT Writing now will not block");
			if(ufds[i].revents & POLLHUP)
				printf("POLLHUP Hung up");
			if(ufds[i].revents & POLLNVAL)
				printf("POLLNVAL Invalid request: fd not open");
			printf("\n");
		}
	}
}

void read_call(const char *device)
{
	struct js_event event;
	int size, fd;
	/* Don't block here. */
	fd = open(device, O_RDONLY);
	if(fd == -1)
	{
		fprintf(stderr, "Error opening %s: %s\n",
			device, strerror(errno));
		exit(1);
	}
	for(;;)
	{
		size = read(fd, &event, sizeof(event));
		if(size == -1)
		{
			fprintf(stderr, "%s Error reading data: %s\n",
				__FUNCTION__, strerror(errno));
			exit(1);
		}
		else
		{
			printf("%s read %d bytes\n", __FUNCTION__, size);
		}
	}
}

int main(int argc, char **argv)
{
	int result;
	const char *device;
	if(argc != 2)
	{
		fprintf(stderr, "Usage: %s /dev/jsN\n", argv[0]);
		return -1;
	}
	device = argv[1];

	result = fork();
	if(result==-1)
	{
		perror("Error on fork.");
		return -1;
	}
	if(result)
	{
		result = fork();
		if(result == -1)
		{
			perror("Error on fork.");
			return -1;
		}
		if(result)
		{
			select_call(device);
		}
		else
		{
			read_call(device);
		}
	}
	else
	{
		poll_call(device);
	}
	return 0;
}

--Q68bSM7Ycu6FN28Q--
