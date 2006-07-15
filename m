Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030254AbWGOTse@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030254AbWGOTse (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jul 2006 15:48:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030255AbWGOTse
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jul 2006 15:48:34 -0400
Received: from smtp104.sbc.mail.mud.yahoo.com ([68.142.198.203]:32354 "HELO
	smtp104.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1030254AbWGOTsd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jul 2006 15:48:33 -0400
From: David Brownell <david-b@pacbell.net>
To: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: rtcwakeup.c
Date: Sat, 15 Jul 2006 12:48:07 -0700
User-Agent: KMail/1.7.1
References: <200607151240.51192.david-b@pacbell.net>
In-Reply-To: <200607151240.51192.david-b@pacbell.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200607151248.07864.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> p.s. A followup message will include a userspace program which
>      makes it easier to try the RTC wakeup mechanism.

For example, if your system actually supports RTC wakeup correctly:

        rtcwake -t $(date -u -d 'tomorrow 6:30am' +'%s') -m mem

will set up the system to wake up tomorrow at 6:30am, then suspend-to-RAM by
writing "mem" to /sys/power/state.  

Or for testing kernels, unattended scripts like this may help:

        while true
        do
                echo "suspend-to-disk for 10 minutes starting $(date)"
                rtcwake -s $((10 * 60)) -m disk
                sleep 500
        done

If there are many RTC utilities out there that aren't x86-specific, I didn't
happen to find them.  Ergo this one.

- Dave



#include <stdio.h>
#include <getopt.h>
#include <fcntl.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <errno.h>
#include <time.h>

#include <sys/ioctl.h>
#include <sys/time.h>
#include <sys/types.h>

#include <linux/rtc.h>

// #define	DEBUG


/*
 * rtcwake -- enter a system sleep state until specified wakeup time.
 *
 * This uses cross-platform Linux interfaces to enter a system sleep state,
 * and leave it no later than a specified time.  It uses any RTC framework
 * driver that supports standard driver model wakeup flags.
 *
 * This is normally used like the old "apmsleep" utility, to wake from a
 * suspend state like ACPI S1 (standby) or S3 (suspend-to-RAM).  Most
 * platforms can implement those without analogues of BIOS, APM, or ACPI.
 *
 * On some systems, this can also be used like "nvram-wakeup", waking
 * from states like ACPI S4 (suspend to disk).  Not all systems have
 * persistent media that are appropriate for such suspend modes.
 */

static char		*progname;

#ifdef	DEBUG
#define	VERSION	"1.0 dev (" __DATE__ " " __TIME__ ")"
#else
#define	VERSION	"0.8"
#endif

static unsigned		verbose;

static int may_wakeup(const char *devname)
{
	char	buf[128], *s;
	FILE	*f;

	snprintf(buf, sizeof buf, "/sys/class/rtc/%s/device/power/wakeup",
			devname);
	f = fopen(buf, "r");
	if (!f) {
		perror(buf);
		return 0;
	}
	fgets(buf, sizeof buf, f);
	fclose(f);

	s = strchr(buf, '\n');
	if (!s)
		return 0;
	*s = 0;

	/* wakeup events could be disabled or not supported */
	return strcmp(buf, "enabled") == 0;
}

/* all times should be in UTC */
static time_t	sys_time;
static time_t	rtc_time;

static int get_basetimes(int fd)
{
	struct tm	tm;
	time_t		offset;
	struct rtc_time	rtc;

	/* record offset of mktime(), so we can reverse it */
	memset(&tm, 0, sizeof tm);
	tm.tm_year = 70;
	offset = mktime(&tm);

	/* read system and rtc clocks "at the same time"; both in UTC */
	sys_time = time(0);
	if (sys_time == (time_t)-1) {
		perror("read system time");
		return 0;
	}
	if (ioctl(fd, RTC_RD_TIME, &rtc) < 0) {
		perror("read rtc time");
		return 0;
	}

	/* convert rtc_time to normal arithmetic-friendly form */
	tm.tm_sec = rtc.tm_sec;
	tm.tm_min = rtc.tm_min;
	tm.tm_hour = rtc.tm_hour;
	tm.tm_mday = rtc.tm_mday;
	tm.tm_mon = rtc.tm_mon;
	tm.tm_year = rtc.tm_year;
	tm.tm_wday = rtc.tm_wday;
	tm.tm_yday = rtc.tm_yday;
	tm.tm_isdst = rtc.tm_isdst;

	if (verbose) {
		printf("\toffset  = %ld\n", offset);
		printf("\tsystime = %s", asctime(gmtime(&sys_time)));
		printf("\trtctime = %s", asctime(&tm));
	}

	rtc_time = mktime(&tm) - offset;
	if (rtc_time == (time_t)-1) {
		perror("convert rtc time");
		return 0;
	}

	return 1;
}

static int setup_alarm(int fd, time_t *wakeup)
{
	struct tm		*tm;
	struct rtc_wkalrm	wake;

	tm = gmtime(wakeup);

	wake.time.tm_sec = tm->tm_sec;
	wake.time.tm_min = tm->tm_min;
	wake.time.tm_hour = tm->tm_hour;
	wake.time.tm_mday = tm->tm_mday;
	wake.time.tm_mon = tm->tm_mon;
	wake.time.tm_year = tm->tm_year;
	wake.time.tm_wday = tm->tm_wday;
	wake.time.tm_yday = tm->tm_yday;
	wake.time.tm_isdst = tm->tm_isdst;

	/* many rtc alarms only support up to 24 hours from 'now' ... */
	if ((rtc_time + 24 * 60 * 60) > *wakeup) {
		if (ioctl(fd, RTC_ALM_SET, &wake.time) < 0) {
			perror("set rtc alarm");
			return 0;
		}
		if (ioctl(fd, RTC_AIE_ON, 0) < 0) {
			perror("enable rtc alarm");
			return 0;
		}

	/* ... so use the "more than 24 hours" request only if we must */
	} else {
		/* avoid an extra AIE_ON call */
		wake.enabled = 1;

		if (ioctl(fd, RTC_WKALM_SET, &wake) < 0) {
			perror("set rtc wake alarm");
			return 0;
		}
	}

	return 1;
}

static void suspend_system(const char *suspend)
{
	FILE	*f = fopen("/sys/power/state", "w");

	if (!f) {
		perror("/sys/power/state");
		return;
	}

	fprintf(f, "%s\n", suspend);
	fflush(f);

	/* this executes after wake from suspend */
	fclose(f);
}

int main(int argc, char **argv)
{
	static char		*devname = "rtc0";
	static unsigned		seconds = 0;
	static char		*suspend = "standby";

	int		t;
	int		fd;
	time_t		alarm = 0;

	progname = strrchr(argv[0], '/');
	if (progname)
		progname++;
	else
		progname = argv[0];
	if (chdir("/dev/") < 0) {
		perror("chdir /dev");
		return 1;
	}

	while ((t = getopt(argc, argv, "d:m:s:t:Vv")) != EOF) {
		switch (t) {

		case 'd':
			devname = optarg;
			break;

		/* what system power mode to use?  for now handle only
		 * standardized mode names; eventually when systems define
		 * their own state names, parse /sys/power/state.
		 *
		 * "on" is used just to test the RTC alarm mechanism,
		 * bypassing all the wakeup-from-sleep infrastructure.
		 */
		case 'm':
			if (strcmp(optarg, "standby") == 0
					|| strcmp(optarg, "mem") == 0
					|| strcmp(optarg, "disk") == 0
					|| strcmp(optarg, "on") == 0
					) {
				suspend = optarg;
				break;
			}
			printf("%s: unrecognized suspend state '%s'\n",
					progname, optarg);
			goto usage;

		/* alarm time, seconds-to-sleep (relative) */
		case 's':
			t = atoi(optarg);
			if (t < 0) {
				printf("%s: illegal interval %s seconds\n",
						progname, optarg);
				goto usage;
			}
			seconds = t;
			break;

		/* alarm time, time_t (absolute, seconds since 1/1 1970 UTC) */
		case 't':
			t = atoi(optarg);
			if (t < 0) {
				printf("%s: illegal time_t value %s\n",
						progname, optarg);
				goto usage;
			}
			alarm = t;
			break;

		case 'v':
			verbose++;
			break;

		case 'V':
			printf("%s: version %s\n", progname, VERSION);
			break;

		default:
usage:
			printf("usage: %s [options]"
				"\n\t"
				"-d rtc0|rtc1|...\t(select rtc)"
				"\n\t"
				"-m standby|mem|...\t(sleep mode)"
				"\n\t"
				"-s seconds\t\t(seconds to sleep)"
				"\n\t"
				"-t time_t\t\t(time to wake)"
				"\n\t"
				"-v\t\t\t(verbose messages)"
				"\n\t"
				"-V\t\t\t(show version)"
				"\n",
				progname);
			return 1;
		}
	}

	if (!alarm && !seconds) {
		printf("%s: must provide wake time\n", progname);
		goto usage;
	}

	/* this RTC must exist and (if we'll sleep) be wakeup-enabled */
	fd = open(devname, O_RDONLY);
	if (fd < 0) {
		perror(devname);
		return 1;
	}
	if (strcmp(suspend, "on") != 0 && !may_wakeup(devname)) {
		printf("%s: %s not enabled for wakeup events\n",
				progname, devname);
		return 1;
	}

	/* relative or absolute alarm time, normalized to time_t */
	if (!get_basetimes(fd))
		return 1;
	if (verbose)
		printf("alarm %ld, sys_time %ld, rtc_time %ld, seconds %u\n",
				alarm, sys_time, rtc_time, seconds);
	if (alarm) {
		if (alarm < sys_time) {
			printf("%s: time doesn't go backward to %s",
					progname, ctime(&alarm));
			return 1;
		}
		alarm += sys_time - rtc_time;
	} else
		alarm = rtc_time + seconds + 1;
	if (setup_alarm(fd, &alarm) < 0)
		return 1;

	printf("%s: wakeup from \"%s\" using %s at %s",
			progname, suspend, devname,
			ctime(&alarm));
	fflush(stdout);
	usleep(10 * 1000);

	if (strcmp(suspend, "on") != 0)
		suspend_system(suspend);
	else {
		unsigned long data;

		(void) read(fd, &data, sizeof data);
	}

	if (ioctl(fd, RTC_AIE_OFF, 0) < 0)
		perror("disable rtc alarm interrupt");

	close(fd);
	return 0;
}
