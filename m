Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261963AbTJMVqz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Oct 2003 17:46:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261970AbTJMVqz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Oct 2003 17:46:55 -0400
Received: from tog-wakko4.prognet.com ([207.188.29.244]:36512 "EHLO virago")
	by vger.kernel.org with ESMTP id S261963AbTJMVqu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Oct 2003 17:46:50 -0400
Date: Mon, 13 Oct 2003 14:46:49 -0700
From: Tom Marshall <tmarshall@real.com>
To: linux-kernel@vger.kernel.org
Subject: missed itimer signals in 2.6
Message-ID: <20031013214649.GB13516@real.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0vzXIDBeUiKkjNJl"
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--0vzXIDBeUiKkjNJl
Content-Type: multipart/mixed; boundary="cvVnyQ+4j833TQvp"
Content-Disposition: inline


--cvVnyQ+4j833TQvp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

It seems that with the 2.6 kernel, ITIMER_REAL becomes inaccurate when the
interval is set under about 50ms.  Using a 10ms interval, I get 455 signals
in five seconds (about 9% loss).  The test machine has virtually no load and
this is reproducible across machines of varying speeds.  The test
application is attached.

Typical output under 2.4.22:

  i=3D10, ticks=3D501 (expected 500), elapsed=3D5.008537, drift=3D+0.001468
  i=3D20, ticks=3D251 (expected 250), elapsed=3D5.019925, drift=3D+0.000076
  i=3D30, ticks=3D167 (expected 166), elapsed=3D5.009974, drift=3D+0.000027
  i=3D40, ticks=3D126 (expected 125), elapsed=3D5.039981, drift=3D+0.000020
  i=3D50, ticks=3D101 (expected 100), elapsed=3D5.049980, drift=3D+0.000021

Typical output under 2.6.0-test7:

  i=3D10, ticks=3D455 (expected 500), elapsed=3D5.003323, drift=3D-0.453316
  i=3D20, ticks=3D239 (expected 250), elapsed=3D5.018035, drift=3D-0.238033
  i=3D30, ticks=3D162 (expected 166), elapsed=3D5.021115, drift=3D-0.161113
  i=3D40, ticks=3D122 (expected 125), elapsed=3D5.001113, drift=3D-0.121111
  i=3D50, ticks=3D99 (expected 100), elapsed=3D5.048102, drift=3D-0.098101

--=20
Nothing is illegal if a hundred businessmen decide to do it, and that's true
anywhere in the world.
        -- Andrew Young

--cvVnyQ+4j833TQvp
Content-Type: text/x-csrc; charset=us-ascii
Content-Disposition: attachment; filename="itimertest.c"

/*
 * test itimer
 */

#include <stdlib.h>
#include <stdio.h>

#include <unistd.h>
#include <signal.h>
#include <sys/time.h>
#include <time.h>

#define TEST_INTERVAL_SEC 5

static inline void
tv_sub(struct timeval* ptv1, struct timeval* ptv2)
{
    ptv1->tv_sec  -= ptv2->tv_sec;
    ptv1->tv_usec -= ptv2->tv_usec;
    while (ptv1->tv_usec < 0)
    {
        ptv1->tv_sec--;
        ptv1->tv_usec += 1000*1000;
    }
}

static uint             g_ticks;
static uint             g_interval;
static struct timeval   g_now;

void
itimer_handler(int sig)
{
    g_ticks++;
    g_now.tv_usec += g_interval*1000;
    while (g_now.tv_usec > 1000*1000)
    {
        g_now.tv_usec -= 1000*1000;
        g_now.tv_sec++;
    }
}

void
start_itimer(uint ms)
{
    struct timeval tv;
    struct itimerval val;

    tv.tv_sec = ms/1000;
    tv.tv_usec = (ms%1000)*1000;

    val.it_interval = tv;
    val.it_value = tv;

    signal(SIGALRM, itimer_handler);
    g_ticks = 0;
    g_interval = ms;
    gettimeofday(&g_now, NULL);
    setitimer(ITIMER_REAL, &val, NULL);
}

void
stop_itimer(void)
{
    struct timeval tv;
    struct itimerval val;

    tv.tv_sec = tv.tv_usec = 0;
    val.it_interval = tv;
    val.it_value = tv;

    setitimer(ITIMER_REAL, &val, NULL);
    signal(SIGALRM, SIG_DFL);
}

int
main(void)
{
    int i;
    struct timeval tv_start;
    struct timeval tv_now;

    char drift_sign;
    struct timeval tv_drift;
    struct timeval tv_elapsed;

    for (i = 10; i <= 50; i += 10)
    {
        gettimeofday(&tv_start, NULL);
        start_itimer(i);
        do
        {
            usleep(1000*1000);
            gettimeofday(&tv_now, NULL);
            tv_elapsed = tv_now;
            tv_sub(&tv_elapsed, &tv_start);
        } while (tv_elapsed.tv_sec < TEST_INTERVAL_SEC);
        stop_itimer();

        if (g_now.tv_sec > tv_now.tv_sec ||
            (g_now.tv_sec == tv_now.tv_sec &&
             g_now.tv_usec > tv_now.tv_usec))
        {
            drift_sign = '+';
            tv_drift = g_now;
            tv_sub(&tv_drift, &tv_now);
        }
        else
        {
            drift_sign='-';
            tv_drift = tv_now;
            tv_sub(&tv_drift, &g_now);
        }
        printf("i=%d, ticks=%u (expected %u), elapsed=%ld.%06ld, drift=%c%ld.%06ld\n",
                i, g_ticks, (TEST_INTERVAL_SEC*1000/i),
                tv_elapsed.tv_sec, tv_elapsed.tv_usec,
                drift_sign, tv_drift.tv_sec, tv_drift.tv_usec);
    }
    return 0;
}

--cvVnyQ+4j833TQvp--

--0vzXIDBeUiKkjNJl
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/ix1JqznSmcYu2m8RAsaJAJ9VNjfyk97nGUzlZpPoL/UqlaYybgCeLpd/
mM1dBff/qAEfDWAm6swuu78=
=lwPo
-----END PGP SIGNATURE-----

--0vzXIDBeUiKkjNJl--
