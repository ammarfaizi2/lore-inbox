Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267078AbSKWW1J>; Sat, 23 Nov 2002 17:27:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267083AbSKWW1J>; Sat, 23 Nov 2002 17:27:09 -0500
Received: from keetweej.xs4all.nl ([213.84.46.114]:43478 "EHLO
	muur.intranet.vanheusden.com") by vger.kernel.org with ESMTP
	id <S267078AbSKWW1I>; Sat, 23 Nov 2002 17:27:08 -0500
From: "Folkert van Heusden" <folkert@vanheusden.com>
To: "'David Schwartz'" <davids@webmaster.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: TCP memory pressure question
Date: Sat, 23 Nov 2002 23:34:15 +0100
Message-ID: <001701c29340$749e8110$3640a8c0@boemboem>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook CWS, Build 9.0.2416 (9.0.2910.0)
In-Reply-To: <20021123002812.AAA5286@shell.webmaster.com@whenever>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 	Any comments or suggestions are appreciated. I've found that when we hit
TCP
> memory pressure, many applications become very badly behaved.

What about:

int WRITE(int handle, char *whereto, int len)
{
        int cnt=len;

        while(len>0)
        {
                int rc;

                rc = write(handle, whereto, len);

                if (rc == -1)
                {
                        if (errno == EINTR)
				{
					/* just try again */
				}
				else if (errno == EAGAIN)
				{
					/* give up time-slice */
					if (sched_yield() == -1)
					{
						/* BIG troubles */
                              	syslog(LOG_DEBUG, "WRITE(), during EAGAIN
handling: sched_yield failed! [%d - %s]", errno, strerror(errno));
                               	return -1;
					}
				}
				else
                        {
                                syslog(LOG_DEBUG, "WRITE(): io-error [%d -
%s]", errno, strerror(errno));
                                return -1;
                        }
                }
                else if (rc == 0)
                {
                        return 0;
                }
                else
                {
                        whereto += rc;
                        len -= rc;
                }
        }

        return cnt;
}

