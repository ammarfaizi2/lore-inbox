Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262655AbTHUMog (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Aug 2003 08:44:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262658AbTHUMof
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Aug 2003 08:44:35 -0400
Received: from catv-50624ad9.szolcatv.broadband.hu ([80.98.74.217]:12161 "EHLO
	boszi-lnx.localdomain") by vger.kernel.org with ESMTP
	id S262655AbTHUMoX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Aug 2003 08:44:23 -0400
Message-ID: <3F44BEA2.8010108@freemail.hu>
Date: Thu, 21 Aug 2003 14:44:18 +0200
From: Boszormenyi Zoltan <zboszor@freemail.hu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en, hu
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: How to use an USB<->serial adapter?
Content-Type: multipart/mixed;
 boundary="------------050605070205020307000904"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050605070205020307000904
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

I am experimenting with a Prolific USB<->RS232 adaptor. We have
in-house developments that need serial communication and there
are more and more mainboards that provide only one RS232 connector.
(We would need more in one machine...)
So we decided to try an usb-serial converter. The one we bought
was happily recognized by a RedHat 9 system but I couldn't get
two-way communication over this converter.
The null-modem cable is working both ways, in fact I tested it
with my machine's two real 16550s.
lsmod shows usbserial and pl2303, dmesg shows this:

usb.c: registered new driver serial
usbserial.c: USB Serial support registered for Generic
usbserial.c: USB Serial Driver core v1.4
usbserial.c: USB Serial support registered for PL-2303
usbserial.c: PL-2303 converter detected
usbserial.c: PL-2303 converter now attached to ttyUSB0 \
(or usb/tts/0 for devfs)
pl2303.c: Prolific PL2303 USB to serial adaptor driver v0.9

I use the attached sources (serial.h, [posix|win32]-serial.c)
in my MinGW/Linux dual platform programs for low-level serial
communication. Here are two testprograms that I used.

serialtest2 just listens and waits for incoming bytes.
If it receives one, the answer is the byte it got + 1.
serialtest1 iterates 10 times writing a byte and expecting
the answer.

I tried using /dev/ttyUSB0 and /dev/usb/ttyUSB0 (chmod was needed
to open them by an ordinary user, open(2) and tcsetattr(3)
succeeded. What I found is that I can write to /dev/ttyUSB0
with serialtest1 and serialtest2 successfully reads it from
/dev/ttyS0. But the answer from serialtest2 cannot be read
by serialtest1. If these programs both use a real serial port
(ttyS0 and ttyS1) the communication is successful both ways.

setserial produces an error:

# setserial /dev/ttyUSB0
Cannot get serial info: Invalid argument

And to be sure:

# setserial /dev/ttyUSB1
/dev/ttyUSB1: No such device

as expected.

I have the kernel-smp-2.4.20-19.9 (not the very latest) errata kernel
and all user space errata packages installed/upgraded.

-- 
Best regards,
Zoltán Böszörményi

---------------------
What did Hussein say about his knife?
One in Bush worth two in the hand.


--------------050605070205020307000904
Content-Type: text/plain;
 name="serial.h"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline;
 filename="serial.h"

/*
 * KÃ¶zÃ¶s fejlÃ©c a Win32/POSIX soros programozÃ¡shoz
 */

#include <sys/types.h>

#ifndef NEED_WINDOWS_H
#include <termios.h>
#else
#define WIN32_LEAN_AND_MEAN 1
#include <windows.h>
#endif

extern char *serial_names[];

typedef struct {
#ifdef NEED_WINDOWS_H
	HANDLE		fd;
	DCB		olddcb, newdcb;
	COMMTIMEOUTS	oldto, newto;
	size_t		err;
#else
	int		fd;
	struct termios	oldtio, newtio;
	ssize_t		err;
#endif
} serial_t;

serial_t *serial_open(const char *devname);
void	serial_setup(serial_t *serport);
void	serial_close(serial_t *serport);
void	serial_write(serial_t *serport, const char *buffer, size_t n);
void	serial_read(serial_t *serport, char *buffer, size_t n, int wait);
void	serial_delay(int ms);


--------------050605070205020307000904
Content-Type: text/plain;
 name="posix-serial.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="posix-serial.c"

#ifdef HAVE_CONFIG_H
#  include <config.h>
#endif

#include <malloc.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <unistd.h>
#include <errno.h>
#include "serial.h"

char *serial_names[10] = {
	"",
	"/dev/ttyS0", "/dev/ttyS1", "/dev/ttyS2", "/dev/ttyS3",
	"/dev/usb/ttyUSB0", "/dev/usb/ttyUSB1", "/dev/usb/ttyUSB2", "/dev/usb/ttyUSB3",
	NULL };

serial_t *serial_open(const char *devname) {
	serial_t	*serport;

	serport = malloc(sizeof(serial_t));

	serport->fd = open(devname, O_RDWR|O_NOCTTY|O_NONBLOCK /*|O_SYNC*/);
	if (serport->fd < 0) {
		free(serport);
		return NULL;
	}

	return serport;
}

void	serial_setup(serial_t *serport) {
	struct termios	*tio1, *tio2;
	int		ret = 0;

	tio1 = &(serport->oldtio);
	tio2 = &(serport->newtio);

	if (tcgetattr(serport->fd, tio1))
		ret = -1;
	memcpy(tio2, tio1, sizeof(struct termios));
	cfmakeraw(tio2);
	cfsetospeed(tio2, B115200);
	cfsetispeed(tio2, B115200);
#if 0
	tio2->c_cflag |= CRTSCTS;
#endif
	tio2->c_cflag |= CREAD|CLOCAL;
	tcflush(serport->fd, TCIOFLUSH);
	if (tcsetattr(serport->fd, TCSANOW, tio2))
		ret = -1;
#if 0
	tcflow(serport->fd, TCOON); tcflow(serport->fd, TCION);
#endif
	serport->err = ret;
}

void	serial_close(serial_t *serport) {
	tcflush(serport->fd, TCIOFLUSH);
	tcsetattr(serport->fd, TCSANOW, &(serport->oldtio));
	close(serport->fd);
	free(serport);
}

void	serial_write(serial_t *serport, const char *buffer, size_t n) {
	int	i;

	serport->err = write(serport->fd, buffer, n);
	tcdrain(serport->fd);
}

void serial_read(serial_t *serport, char *buffer, size_t n, int wait) {
	int pos = 0;
	int err = 0;
	struct timeval tv;
	fd_set set;

	if (wait) {
		FD_ZERO(&set);
		FD_SET(serport->fd, &set);
		tv.tv_sec = 0;
		tv.tv_usec = 250000;
		serport->err = select(serport->fd+1, &set, NULL, NULL, &tv);
		if (serport->err <= 0)
			return;
	}

	while(n--) {
again:
		if (wait) {
			FD_ZERO(&set);
			FD_SET(serport->fd, &set);
			tv.tv_sec = 0;
			tv.tv_usec = 100000;
			serport->err = select(serport->fd+1, &set, NULL, NULL, &tv);
			if (serport->err <= 0)
				return;
		}
		serport->err = read(serport->fd, &buffer[pos++], 1);
		if (serport->err == 0)
			goto again;
		if (serport->err == -1)
			break;
	}
	if (serport->err != -1)
		serport->err = pos;
}

void	serial_delay(int ms) {
	usleep(ms*1000);
}


--------------050605070205020307000904
Content-Type: text/plain;
 name="win32-serial.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="win32-serial.c"

#ifdef HAVE_CONFIG_H
#  include <config.h>
#endif

#define WIN32_LEAN_AND_MEAN 1
#include <windows.h>

#include <malloc.h>
#include <gdk/gdkwin32.h>
#include <gtk/gtk.h>

#include "serial.h"

char *serial_names[10] = {
	"",
	"COM1:", "COM2:", "COM3:", "COM4:",
	"COM5:", "COM6:", "COM7:", "COM8:",
	NULL };

extern GtkWidget *foablak;

serial_t *serial_open(const char *devname) {
	serial_t *serport;
	HANDLE	fd;
	DWORD	dwError;

	serport = malloc(sizeof(serial_t));

	serport->fd = CreateFile(devname, GENERIC_READ|GENERIC_WRITE, 0, NULL, OPEN_EXISTING,
		FILE_FLAG_WRITE_THROUGH, NULL);
	dwError = GetLastError();
	if (dwError == ERROR_FILE_NOT_FOUND) {
		free(serport);
		return NULL;
	}
	return serport;
}

void	serial_setup(serial_t *serport) {
	DCB		*dcb1, *dcb2;
	COMMTIMEOUTS	*to1, *to2;
	DWORD		dwError;

	to1 = &(serport->oldto);
	to2 = &(serport->newto);

	/* Initialize the DCBlength member. */
	dcb1 = &(serport->olddcb);
	dcb2 = &(serport->newdcb);

	serport->olddcb.DCBlength = sizeof (DCB); 

	/* Get the default port setting information. */
	GetCommState(serport->fd, dcb1);
	memcpy(dcb2, dcb1, sizeof(DCB));

	/* Change the DCB structure settings. */
	dcb2->BaudRate = 115200;            /* Current baud */
	dcb2->fBinary = TRUE;               /* Binary mode; no EOF check */
	dcb2->fParity = TRUE;               /* Enable parity checking */
	dcb2->fOutxCtsFlow = FALSE;         /* No CTS output flow control */
	dcb2->fOutxDsrFlow = FALSE;         /* No DSR output flow control */
	dcb2->fDtrControl = DTR_CONTROL_DISABLE /* DTR_CONTROL_ENABLE */;
	                                      /* DTR flow control type */
	dcb2->fDsrSensitivity = FALSE;      /* DSR sensitivity */
	dcb2->fTXContinueOnXoff = TRUE;     /* XOFF continues Tx */
	dcb2->fOutX = FALSE;                /* No XON/XOFF out flow control */ 
	dcb2->fInX = FALSE;                 /* No XON/XOFF in flow control */
	dcb2->fErrorChar = FALSE;           /* Disable error replacement */
	dcb2->fNull = FALSE;                /* Disable null stripping */
	dcb2->fRtsControl = RTS_CONTROL_ENABLE;
	                                      /* RTS flow control */
	dcb2->fAbortOnError = FALSE;        /* Do not abort reads/writes error */
	dcb2->ByteSize = 8;                 /* Number of bits/byte, 4-8 */
	dcb2->Parity = NOPARITY;            /* 0-4=no,odd,even,mark,space */ 
	dcb2->StopBits = ONESTOPBIT;        /* 0,1,2 = 1, 1.5, 2 */

	/* Configure the port according to the specifications of the DCB structure. */
	if (!SetCommState (serport->fd, dcb2)) {
		/* Could not configure the serial port. */
		serport->err = -1;
		return;
	}

	/* Retrieve the time-out parameters for all read and write operations
	   on the port. */
	to1 = &(serport->oldto);
	to2 = &(serport->newto);

	GetCommTimeouts (serport->fd, to1);
	memcpy(to2, to1, sizeof(COMMTIMEOUTS));

	/* Change the COMMTIMEOUTS structure settings. */
	to2->ReadIntervalTimeout = 250;
	to2->ReadTotalTimeoutMultiplier = 0;
	to2->ReadTotalTimeoutConstant = 250;
	to2->WriteTotalTimeoutMultiplier = 0;
	to2->WriteTotalTimeoutConstant = 0;

	/* Set the time-out parameters for all read and write operations
	   on the port. */
	if (!SetCommTimeouts (serport->fd, to2))
	{
		/* Could not set the time-out parameters. */
		serport->err = -1;
		return;
	}
}

void serial_close(serial_t *serport) {
	SetCommState (serport->fd, &(serport->olddcb));
	SetCommTimeouts (serport->fd, &(serport->oldto));
	CloseHandle(serport->fd);
	free(serport);
}

void serial_write(serial_t *serport, const char *buffer, size_t n) {
	DWORD	dwNumBytesWritten;
	int	i;

	serport->err = 0;
	for (i = 0; i < n; i++) {
		WriteFile (serport->fd,	/* Port handle */
			&buffer[i],	/* Pointer to the data to write */
			1,		/* Number of bytes to write */
			&dwNumBytesWritten,/* Pointer to the number of bytes written */
			NULL);		/* Must be NULL for Windows CE */
		serport->err += dwNumBytesWritten;
	}
	if (serport->err != n)
		serport->err = -1;
}

void serial_read(serial_t *serport, char *buffer, size_t n, int wait) {
	DWORD dwBytesTransferred;
	int	i;

	serport->err = 0;
	for (i = 0; i < n; i++) {
		ReadFile (serport->fd,	/* Port handle */
          	&buffer[i],		/* Pointer to data to read */
		1,			/* Number of bytes to read */
		&dwBytesTransferred,	/* Pointer to number of bytes read */
		NULL);			/* Must be NULL for Windows CE */
		serport->err += dwBytesTransferred;
		if (!dwBytesTransferred) {
			serport->err = -1;
			break;
		}
	}
	if (serport->err != n)
		serport->err = -1;
}

void	serial_delay(int ms) {
	Sleep(ms);
}


--------------050605070205020307000904
Content-Type: text/plain;
 name="serialtest1.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="serialtest1.c"

/*
 *  serialtest1
 */

#include <stdio.h>
#include "serial.h"

serial_t	*sp;
unsigned char	c1, c2;
int		i;

int main(int argc, char **argv) {
	if (argc != 2)	{
		printf("give device name\n");
		return 1;
	}

	sp = serial_open(argv[1]);
	if (!sp) {
		printf("cannot open %s\n", argv[1]);
		return 1;
	}

	serial_setup(sp);
	if (sp->err < 0) {
		printf("cannot setup %s\n", argv[1]);
	}

	for (i = 0; i < 10; i++) {
		c1 = i;

		serial_write(sp, &c1, 1);

		serial_delay(20);

		serial_read(sp, &c2, 1, 1);

		if (sp->err <= 0)
		printf("written: 0x%02x, couldn't read\n", c1);
			else
		printf("written: 0x%02x, read: 0x%02x\n", c1, c2);
	}

	serial_close(sp);

	return 0;
}



--------------050605070205020307000904
Content-Type: text/plain;
 name="serialtest2.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="serialtest2.c"

/*
 *  serialtest2
 */

#include <stdio.h>
#include <stdlib.h>
#include "serial.h"

serial_t	*sp;
unsigned char	c1, c2;
int		i;

void myexit(void) {
	serial_close(sp);
}

int main(int argc, char **argv) {
	if (argc != 2) {
		printf("give device name\n");
		return 1;
	}

	sp = serial_open(argv[1]);
	if (!sp) {
		printf("cannot open %s\n", argv[1]);
		return 1;
	}

	serial_setup(sp);
	if (sp->err < 0) {
		printf("cannot setup %s\n", argv[1]);
	}

	atexit(myexit);

	while (1) {
again:
		serial_read(sp, &c1, 1, 1);
		if (sp->err <= 0)
			goto again;

		c2 = c1+1;

		serial_write(sp, &c2, 1);
		printf("read: 0x%02x, written: 0x%02x\n", c1, c2);

	}

	return 0;
}



--------------050605070205020307000904--

