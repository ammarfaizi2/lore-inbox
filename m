Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285147AbRL2RlS>; Sat, 29 Dec 2001 12:41:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285166AbRL2RlF>; Sat, 29 Dec 2001 12:41:05 -0500
Received: from net015s.hetnet.nl ([194.151.104.155]:59154 "EHLO hetnet.nl")
	by vger.kernel.org with ESMTP id <S285147AbRL2Rkh>;
	Sat, 29 Dec 2001 12:40:37 -0500
Message-Id: <5.1.0.14.2.20011229174504.00a291b0@pop.hetnet.nl>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Sat, 29 Dec 2001 18:27:32 +0100
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
From: Henk de Groot <henk.de.groot@hetnet.nl>
Subject: Re: AX25/socket kernel PATCHes
Cc: linux-hams@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <E16K68F-00029E-00@the-village.bc.nu>
In-Reply-To: <5.1.0.14.2.20011228213437.009d1190@pop.hetnet.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Alan,

At 23:09 28-12-01 +0000, Alan Cox wrote:
>>                       wake_up_interruptible(sk->sleep);
>
>Does the fix work without this change ?

I haven't tried, but I saw the mail that Jeroen is working on something better so better wait for that. In the meantime I use this intermediate patch on my system because its better than feezing up the system - even if its not the correct way.

One other very long-term issue. When using programs that need raw AX.25 TX access like my program DIGI_NED and net2kiss the kernel outputs a warning "kernel: protocol 0000 is buggy, dev bcsf0" (when using BayCom in this case, other flavors are scc0, yam0 etc.). This messages originates from net/core/dev.c line 901 (2.4.17) and was introduced way back in the 2.1.x kernel (2.0.36 did not have this messages).

 From a layman's view it looks like transmitted data is comming back or something like that. I tried to implement the access to the socket from the user point of view (application) the correct way; it looks like a driver problem. The appletalk driver used to have the same problem.

The message doesn't seem to matter but I frequently get messages about this since using the DIGI_NED digipeater provokes a lot of these messages. I attached the code segment I use to interface below (the complete code is available through http://www.qsl.net/digi_ned/).

My proposal is either to fix the drivers to set skb->nh correctly (no idea where and how this should be done, otherwise I would have supplied a patch) or to remove the message (at least for AX.25 use). There must be a reason why this printk is done so the first would be preferred. If there is something I could do at application level than that would be okay to, but I don't see how I could set skb->nh from the application.

Thanks for the excellent work!

Kind regards,

Henk.

Quick guide to the code below to find things:

The sockets are opened in: short init_mac(void)
Writing is done in: short mac_out(frame_t far *frame_p) using sendto
Probing for received data is done in: short mac_avl(void) using select
Reading data is done in: short mac_inp(frame_t far *frame_p)

I think the "buggy" messages are caused directly or indirectly following the sendto call. The way of reception is employed by more programs (listen e.g.) and does not cause problems, net2kiss however uses a similar transmission method and also provokes these "buggy" messages.

/*
 *  Copyright (C) 2000-2001  Henk de Groot - PE1DNN
 *
 *  This program is free software; you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation; either version 2 of the License, or
 *  (at your option) any later version.
 *
 *  This program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with this program; if not, write to the Free Software
 *  Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
 *  Please note that the GPL allows you to use the driver, NOT the radio.
 *  In order to use the radio, you need a license from the communications
 *  authority of your country.
 */

#ifndef _LINUX_
#include <dos.h>
#endif /* _LINUX_ */
#include <ctype.h>
#include <stdio.h>
#include <stdlib.h>
#ifndef _LINUX_
#include <mem.h>
#endif /* _LINUX_ */
#include <string.h>
#ifdef _LINUX_
#include <unistd.h>
#include <errno.h>
#include <sys/time.h>
#include <sys/types.h>
#include <net/if.h>
#include "linux.h"
#endif /* _LINUX_ */
#include "digicons.h"
#include "digitype.h"
#include "genlib.h"
#include "read_ini.h"
#include "mac_if.h"
#include "timer.h"
#include "output.h"
#ifdef _LINUX_
#include <sys/socket.h>
#include <linux/ax25.h>
#include <linux/rose.h>
#include <linux/if_ether.h>
#include <asm/byteorder.h>

#ifdef NEW_AX25
#include <netax25/axlib.h>
#include <netax25/axconfig.h>
#else
#include <ax25/axutils.h>
#include <ax25/axconfig.h>
#endif /* NEW_AX25 */
#endif /* _LINUX_ */

#define MAC_CHECK  1
#define MAC_INPUT  2
#define MAC_OUTPUT 3
#define MAC_PORTS  0x0fb
#define MAC_DEBUG  0x0fd

#ifndef _LINUX_
static unsigned char hdr_mac[]  = "??AX25_MAC";
#endif /* _LINUX_ */

unsigned short mac_vector = 0;

#ifdef _LINUX_
typedef struct ports_s {
    int    s_out;
    char  *dev_p;
    char  *port_p;
} ports_t;
static ports_t lnx_port[MAX_PORTS];
static int     lnx_port_nr = 0;
static int     lnx_s_in;
#endif /* _LINUX_ */

/* AX25_MAC call to check if RX data is available */
short mac_avl(void)
{
#ifndef _LINUX_
    union REGS inregs;
    union REGS outregs;

    if(mac_vector == 0)
        return 0;

    inregs.h.ah = MAC_CHECK;
    int86(mac_vector, &inregs, &outregs);
    if(outregs.x.ax == 1)
        return 1;
    return 0;
#else
    struct timeval tv;
    fd_set fds;
    int retval;

    /* Watch stdin (fd 0) to see when it has input. */
    FD_ZERO(&fds);
    FD_SET(lnx_s_in, &fds);

    /* wait only a short time (not 0, that gives a very high load!) */
    tv.tv_sec = 0;
    tv.tv_usec = 10;

    retval = select(lnx_s_in + 1, &fds, NULL, NULL, &tv);

    if (retval != 0)
    {
        /* data available */
        return 1;
    }

    /* no data */
    return 0;
#endif /* _LINUX_ */
}

/* AX25_MAC call to retrieve RX data */
short mac_inp(frame_t far *frame_p)
{
#ifndef _LINUX_
    union REGS inregs;
    union REGS outregs;
    struct SREGS sregs;

    if(mac_vector == 0)
        return -1;

    inregs.h.ah = MAC_INPUT;
    sregs.es    = FP_SEG(frame_p);
    inregs.x.di = FP_OFF(frame_p);

    int86x(mac_vector, &inregs, &outregs, &sregs);

    return outregs.h.al;
#else
    struct sockaddr  from;
    unsigned int     from_len;
    char             data[MAX_FRAME_LENGTH + 1];
    int              data_length;
    int              i;
    ports_t         *prt_p;

    from_len = sizeof(from);
    data_length = recvfrom(lnx_s_in, data, MAX_FRAME_LENGTH + 1, 0,
                                                            &from, &from_len);

    if(data_length < 0) {
        if (errno == EWOULDBLOCK)
            return -1;
        say("Error returned from \"recvfrom\" in function mac_inp()\r\n");
        exit(1);
    }

    if(data_length < 2)
        return -1; /* short packet */

    if(data[0] != 0)
        return -1; /* not a data packet */

    data_length--;

    memcpy(frame_p->frame, &(data[1]), data_length);
    frame_p->len  = data_length;

    /* find out from which port this came */
    for(i = 0; i < lnx_port_nr; i++)
    {
        prt_p      = &(lnx_port[i]);

        if(strcmp(prt_p->dev_p, from.sa_data) == 0)
        {
            /* found it! */
            frame_p->port = i;
            return 0;
        }
    }

    /* data on a port we don't use for DIGI_NED */
    return -1;
#endif /* _LINUX_ */
}

/* AX25_MAC call to put TX data in the MAC layer */
short mac_out(frame_t far *frame_p)
{
#ifndef _LINUX_
    union REGS inregs;
    union REGS outregs;
    struct SREGS sregs;

    if(mac_vector == 0)
        return 0;

    inregs.h.ah = MAC_OUTPUT;
    sregs.es    = FP_SEG(frame_p);
    inregs.x.di = FP_OFF(frame_p);

    int86x(mac_vector, &inregs, &outregs, &sregs);

    return outregs.h.al;
#else
    struct sockaddr  to;
    char             data[MAX_FRAME_LENGTH + 1];
    int              res;
    ports_t         *prt_p;

    prt_p = &(lnx_port[(short) frame_p->port]);

    bzero(&to,sizeof(struct sockaddr));
    to.sa_family = AF_INET;
    strcpy(to.sa_data, prt_p->dev_p);

    data[0] = 0; /* this is data */
    memcpy(&data[1], frame_p->frame, frame_p->len);

    res = sendto(prt_p->s_out, data, frame_p->len + 1, 0, &to, sizeof(to));
    if (res >= 0)
    {
            return 0;
    }
    if (errno == EMSGSIZE) {
            vsay("Sendto: packet (size %d) too long\r\n", frame_p->len + 1);
            return -1;
    }
    if (errno == EWOULDBLOCK) {
            vsay("Sendto: busy\r\n", frame_p->len);
            return -1;
    }
    perror("sendto");
    return -1;
#endif /* _LINUX_ */
}

/* AX25_MAC call to retrieve the number of active ports */
short mac_ports(void)
{
#ifndef _LINUX_
    union REGS inregs;
    union REGS outregs;

    if(mac_vector == 0)
        return 0;

    inregs.h.ah = MAC_PORTS;
    int86(mac_vector, &inregs, &outregs);

    return (short) outregs.h.al;
#else
    return lnx_port_nr;
#endif /* _LINUX_ */
}

/*
 * convert a raw AX.25 frame to a disassembled frame structure
 *
 * returns: 0 if frame could not be decoded
 *          1 if frame could be decoded and has a supported PID
 *         -1 if frame could be decoded but has an unsupported PID
 *         -2 if frame could be decoded but has an illegal call
 */
static short frame2uidata(frame_t *frame_p, uidata_t *uidata_p)
{
    unsigned char  i,j;
    unsigned short k;
    unsigned short ndigi;
    unsigned short ssid;
    unsigned short len;
    unsigned char *bp;
    unsigned short pid;
    unsigned short call_ok;
    char          *p;
    
    /* assume all calls are okay */
    call_ok = 1;
    
    uidata_p->port = frame_p->port;
    len = frame_p->len;
    bp  = &(frame_p->frame[0]);

    if (!bp || !len) 
    {
        vsay("Short packet (no data)\r\n");
        return 0;
    }

    if (len < 15)
    {
        vsay("Short packet (< 15 bytes)\r\n");
        return 0;
    }

    if (bp[1] & 1) /* Compressed FlexNet Header */
    {
        vsay("Compressed FlexNet header in packet, not supported\r\n");
        return 0;
    }

    /* cleanup data size before beginning to decode */
    uidata_p->size = 0;

    /* Destination of frame */
    j = 0;
    for(i = 0; i < 6; i++)
    {
        if ((bp[i] &0xfe) != 0x40)
            uidata_p->destination[j++] = bp[i] >> 1;
    }
    ssid = (bp[6] & SSID_MASK) >> 1;
    if(ssid != 0)
    {
        uidata_p->destination[j++] = '-';
        if((ssid / 10) != 0)
        {
            uidata_p->destination[j++] = '1';
        }
        ssid = (ssid % 10);
        uidata_p->destination[j++] = ssid + '0';
    }
    uidata_p->dest_flags = bp[6] & FLAG_MASK;
    uidata_p->destination[j] = '\0';
    if(is_call(uidata_p->destination) == 0)
    {
        vsay("Invalid Destination call in received packet\r\n");
        call_ok = 0;
    }

    bp += 7;
    len -= 7;

    /* Source of frame */
    j = 0;
    for(i = 0; i < 6; i++) 
    {
        if ((bp[i] &0xfe) != 0x40)
            uidata_p->originator[j++] = bp[i] >> 1;
    }
    ssid = (bp[6] & SSID_MASK) >> 1;
    if(ssid != 0)
    {
            uidata_p->originator[j++] = '-';
            if((ssid / 10) != 0)
            {
                uidata_p->originator[j++] = '1';
            }
            ssid = (ssid % 10);
            uidata_p->originator[j++] = ssid + '0';
    }
    uidata_p->orig_flags = bp[6] & FLAG_MASK;
    uidata_p->originator[j] = '\0';
    if(is_call(uidata_p->originator) == 0)
    {
        vsay("Invalid Originator call in received packet\r\n");
        call_ok = 0;
    }

    bp += 7;
    len -= 7;

    /* Digipeaters */
    ndigi=0;
    while ((!(bp[-1] & END_FLAG)) && (len >= 7))
    {
        /* Digi of frame */
        if(ndigi != 8)
        {
            j = 0;
            for(i = 0; i < 6; i++)
            {
                if ((bp[i] &0xfe) != 0x40) 
                    uidata_p->digipeater[ndigi][j++] = bp[i] >> 1;
            }
            if(j == 0)
            {
                vsay("Short Digipeater call found (0 bytes length)\r\n");
                call_ok = 0;
            }
            uidata_p->digi_flags[ndigi] = (bp[6] & FLAG_MASK);
            ssid = (bp[6] & SSID_MASK) >> 1;
            if(ssid != 0)
            {
                    uidata_p->digipeater[ndigi][j++] = '-';
                    if((ssid / 10) != 0)
                    {
                        uidata_p->digipeater[ndigi][j++] = '1';
                    }
                    ssid = (ssid % 10);
                    uidata_p->digipeater[ndigi][j++] = ssid + '0';
            }
            uidata_p->digipeater[ndigi][j] = '\0';
            if(is_call(uidata_p->digipeater[ndigi]) == 0)
            {
                vsay("Invalid Digipeater call in received packet\r\n");
                call_ok = 0;
            }
            ndigi++;
        }
        bp += 7;
        len -= 7;

    }
    uidata_p->ndigi = ndigi;

    /* if at the end, short packet */
    if(!len) 
    {
        vsay("Short packet (no primitive found)\r\n");
        return 0;
    }

    /* We are now at the primitive bit */
    uidata_p->primitive = *bp;
    bp++;
    len--;
    /* Flag with 0xffff that we don't have a PID */
    uidata_p->pid = 0xffff; 

    /* if there were call decoding problems return now */
    if(call_ok == 0)
    {
        return -2;
    }

    /*
     * Determine if a packet is received LOCAL (i.e. direct) or
     * REMOTE (i.e. via a digipeater)
     */
    if(uidata_p->ndigi == 0)
    {
        /* no digipeaters at all, must be LOCAL then */
        uidata_p->distance = LOCAL;
    }
    else
    {
        /* there are digi's, look if it was repeated at least once */
        if((uidata_p->digi_flags[0] & H_FLAG) != 0)
        {
            /* this packet was digipeated and thus not received localy */
            uidata_p->distance = REMOTE;
        }
        else
        {
            /*
             * Here are the exceptions! With these exceptions no H_FLAG
             * is set on the first digipeater although the packet was
             * already digipeated one or more times.
             *
             * These are two types of digipeating use this:
             *
             * 1) Digipeating on destination-SSID. After the first hop
             * the digipeater-call of the first digipeater is added
             * without a H_FLAG. Subsequent digipeaters do not change
             * this until the SSID reaches 0. When the SSID reaches 0
             * the H_FLAG on the existing first digipeater call is set.
             *
             * Example flow, starting with destination SSID=3
             * PE1DNN>APRS-3:>Digipeating...               Direct packet
             * PE1DNN>APRS-2,PE1DNN-2:>Digipeating...      First hop
             * PE1DNN>APRS-1,PE1DNN-2:>Digipeating...      Second hop
             * PE1DNN>APRS,PE1DNN-2*:>Digipeating...       Third hop
             *
             * 2) Intelligent digipeater calls counting down or even
             * finished counting down... The H_FLAG may be set when
             * the call is completely "used", but this is not always
             * the case.
             *
             * Example flow, starting with destination WIDE3-3
             * PE1DNN>APRS,WIDE3-3:>Digipeating...         Direct packet
             * PE1DNN>APRS,WIDE3-2:>Digipeating...         First hop
             * PE1DNN>APRS,WIDE3-1:>Digipeating...         Second hop
             * PE1DNN>APRS,WIDE3*:>Digipeating...          Third hop
             * (if the packet in the third hop passed a Kantronics TNC
             *  with NOID set, then the TNC will not mark WIDE3 with a
             *  H_FLAG,i.e PE1DNN>APRS,WIDE3:>Digipeating...)
             */

            /*
             * Check if the packet is digipeating on SSID. This is the
             * case when the destination SSID is not '0'. We only need
             * to find the '-' on the destination call. With SSID = '0'
             * the '-' is not present.
             */
            p = strchr(uidata_p->destination, '-');
            if(p != NULL)
            {
                /*
                 * Destination SSID is not '0', assume digipeating on
                 * destination SSID. I.e the packet was already repeated
                 * once because there is an unused digipeater call in the
                 * digipeater list. With digipeating on destination-SSID
                 * the starting packet should not have any digipeaters at
                 * all.
                 */
                uidata_p->distance = REMOTE;
            }
            else
            {
                /*
                 * Check if it is an "Intelligent" digi-call which is in
                 * progress counting down or is finished.
                 */
                p = strchr(uidata_p->digipeater[0], '-');
                if(p == NULL)
                {
                    /*
                     * No dash, the SSID of the first digipeater is '0'
                     *
                     * Check if the call ends with a digit 1 to 7 so it
                     * could have been an intelligent digipeater call which
                     * is finished but not marked as "used".
                     */
                    /*
                     * Let 'p' point to the last character of the digipeater
                     * call (using index -1 is save, the length is > 0 which
                     * has been checked earlier in this function).
                     */
                    p = uidata_p->digipeater[0];
                    p = &(p[strlen(p) - 1]);

                    /*
                     * The last digit of the call shall be between 1 and 7
                     * to qualify for an intelligent digipeater call
                     */
                    if((*p > '0') && (*p < '8'))
                    {
                        /*
                         * Assume this is a call left behind by a Kantronics
                         * TNC which did not mark the final WIDEn call with
                         * a H_FLAG.
                         *
                         * Assume this packet has been repeated and is not
                         * local.
                         */
                        uidata_p->distance = REMOTE;
                    }
                    else
                    {
                        /*
                         * not an 'Intelligent' digi call (does not end
                         * with a digit 1..7), must be local then
                         */
                        uidata_p->distance = LOCAL;
                    }
                }
                else
                {
                    /*
                     * Pointer 'p' is now setup as follows:
                     *
                     * p[-1] is the last character of the call
                     * p[0] is the dash
                     * p[1] is the SSID
                     * p[2] is '\0' if the SSID is < 10
                     */

                    /*
                     * check if the SSID after the dash is a digit which
                     * can be used for intelligent digipeating (1-7).
                     * We already checked for 0, so SSID should be one digit
                     * in size ('\0' should follow) and less than 8
                     */
                    if((p[2] == '\0') && (p[1] < '8'))
                    {
                        /*
                         * The last digit of the call shall be between 1 and 7
                         * too to qualify for an intelligent digipeater call
                         */
                        if((p[-1] > '0') && (p[-1] < '8'))
                        {
                            /*
                             * if the last digit of the call is bigger than
                             * the SSID it may be a Intelligent call busy
                             * counting down.
                             */
                            if(p[-1] > p[1])
                            {
                                /*
                                 * Most likely an Intelligent digi-call
                                 * busy counting down
                                 * Assume this has been repeated and is not
                                 * local.
                                 */
                                uidata_p->distance = REMOTE;
                            }
                            else
                            {
                                /*
                                 * A not started intelligent digi call
                                 * countdown or not an intelligent digi
                                 * call at all. Must be local then.
                                 */
                                uidata_p->distance = LOCAL;
                            }
                        }
                        else
                        {
                            /*
                             * not an 'Intelligent' digi call (does not end
                             * with a digit 1..7), must be local then
                             */
                            uidata_p->distance = LOCAL;
                        }
                    }
                    else
                    {
                        /*
                         * SSID > 7, cannot be used for 'intelligent
                         * digipeating'
                         *
                         * This must be a normal call which has not been
                         * used, the packet is local.
                         */
                        uidata_p->distance = LOCAL;
                    }
                }
            }
        }
    }

    /* No data left, ready */
    if (!len)
    {
        /* this is not an UI frame, in kenwood_mode it should be ignored */
        if(digi_kenwood_mode == 0)
        {
            return 1;
        }
        else
        {
            return -1;
        }
    }

    /* keep the PID */
    pid = ((short) *bp) & 0x00ff; 
    uidata_p->pid = pid;
    bp++;
    len--;

    k = 0;
    while (len)
    {
        i = *bp++;

        if(k < 256) uidata_p->data[k++] = i;

        len--;
    }
    uidata_p->size = k;

    if(call_ok == 0)
    {
        return -2;
    }

    if(digi_kenwood_mode == 0)
    {
        /* check PID */
        if( (pid != 0xf0) /* normal AX.25 */
            &&
            (pid != 0xcc) /* not IP datagram */
            &&
            (pid != 0xcd) /* not ARP */
            &&
            (pid != 0xcf) /* not NETROM */
          )
        {
            /* only support for AX.25, IP, ARP and NETROM packets, bail out */
            return -1;
        }
    }
    else
    {
        /* only support for normal AX.25 UI frames, if not, bail out */
        if(((uidata_p->primitive & ~0x10) != 0x03) || (uidata_p->pid != 0xf0))
        {
            /* not a normal AX.25 UI frame, bail out */
            return -1;
        }
    }

    return 1;
}

/*
 * convert a disassembled frame structure to a raw AX.25 frame 
 */
static void uidata2frame(uidata_t *uidata_p, frame_t *frame_p)
{
    unsigned char  i,j;
    unsigned short k;
    unsigned short ssid;
    unsigned short len;
    unsigned char *bp;

    frame_p->port = uidata_p->port;

    bp = &(frame_p->frame[0]);

    len = 0; /* begin of frame */

    /* Destination of frame */
    j = 0;
    for(i = 0; i < 6; i++)
    {
        /* if not end of string or at SSID mark */
        if((uidata_p->destination[j] != '\0')
           &&
           (uidata_p->destination[j] != '-'))
        {
            bp[i] = (uidata_p->destination[j++] << 1);
        }
        else
        {
            bp[i] = 0x40;
        }
    }
    if(uidata_p->destination[j] == '-')
    {
        /* "j" points to the SSID mark */
        j++;
        
        ssid = uidata_p->destination[j++] - '0';
        if(uidata_p->destination[j] != '\0')
        {
            ssid = (10 * ssid) + (uidata_p->destination[j++] - '0');
        }
    }
    else
    {
        ssid = 0;
    }
    bp[6] = (ssid << 1) | uidata_p->dest_flags;
    bp += 7;
    len += 7;

    /* Source of frame */
    j = 0;
    for(i = 0; i < 6; i++)
    {
        /* if not end of string or at SSID mark */
        if((uidata_p->originator[j] != '\0')
           &&
           (uidata_p->originator[j] != '-'))
        {
            bp[i] = (uidata_p->originator[j++] << 1);
        }
        else
        {
            bp[i] = 0x40;
        }
    }
    if(uidata_p->originator[j] == '-')
    {
        /* "j" points to the SSID mark */
        j++;

        ssid = uidata_p->originator[j++] - '0';
        if(uidata_p->originator[j] != '\0')
        {
            ssid = (10 * ssid) + (uidata_p->originator[j++] - '0');
        }
    }
    else
    {
        ssid = 0;
    }
    bp[6] = (ssid << 1) | uidata_p->orig_flags;
    bp += 7;
    len += 7;

    /* Digipeaters */
    for(k = 0; k < uidata_p->ndigi; k++)
    {
        /* check if the distribution distance should be LOCAL */
        if( uidata_p->distance == LOCAL )
        {
            /*
             * to keep the frame local avoid that it is digipeated after
             * we transmitted it, there shall not be any unused digipeater
             * in the frame. break out of the loop if an unused digipeater
             * is encountered
             *
             * an unused digipeater doesn't have its H_BIT set in the SSID
             */
            if((uidata_p->digi_flags[k] & H_FLAG) == 0)
            {
                /* don't put "unused" digipeaters in the frame */
                break; /* break out of the for loop */
            }
        }

        j = 0;
        for(i = 0; i < 6; i++)
        {
            /* if not end of string or at SSID mark */
            if((uidata_p->digipeater[k][j] != '\0')
               &&
               (uidata_p->digipeater[k][j] != '-'))
            {
                bp[i] = (uidata_p->digipeater[k][j++] << 1);
            }
            else
            {
                bp[i] = 0x40;
            }
        }
        if(uidata_p->digipeater[k][j] == '-')
        {
            /* "j" points to the SSID mark */
            j++;

            ssid = uidata_p->digipeater[k][j++] - '0';
            if(uidata_p->digipeater[k][j] != '\0')
            {
                ssid = (10 * ssid) + (uidata_p->digipeater[k][j++] - '0');
            }
        }
        else
        {
            ssid = 0;
        }
        bp[6] = (ssid << 1) | uidata_p->digi_flags[k];
        bp += 7;
        len += 7;
    }

    /* patch bit 1 on the last address */
    bp[-1] = bp[-1] | END_FLAG;

    /* We are now at the primitive bit */
    *bp = uidata_p->primitive;
    bp++;
    len++;

    /* if PID == 0xffff we don't have a PID */
    if(uidata_p->pid == 0xffff)
    {
        frame_p->len = len;
        return;
    }

    /* set the PID */
    *bp = (char) uidata_p->pid;
    bp++;
    len++;

    /* when size == 0 don't copy */
    if(uidata_p->size == 0)
    {
        frame_p->len = len;
        return;
    }

    memcpy(bp, &(uidata_p->data[0]), uidata_p->size);
    len += uidata_p->size;

    frame_p->len = len;

    return;
}

/*
 * Check the uidata packet for overrun of a Kenwood tranceiver
 *
 * Tested for the TH-D7E with version 2.0 prom. Hopefully do
 * the other Kenwood tranceivers have the same limit (if any)
 *
 * Returns:
 *          0 - do not transmit this packet
 *          1 - okay to transmit this packet
 */
short uidata_kenwood_mode(uidata_t *uidata_p)
{
    short budget;
    short i;

    if((digi_kenwood_mode != 1) && (digi_kenwood_mode != 2))
    {
        return 1; /* no special handling at all */
    }

    /* 
     * The packet is assumed to be internally formatted like this:
     *
     *  SOURCE>ID,PATH,PATH*,PATH:Hey look at me, this is my long ID<CR>
     *  <--------------------- Max 195 characters --------------------->
     */

    /* start budget is 195 bytes, this is including the <CR> */
    budget = 195;
    
    /* start to count down */
    budget = budget - strlen(uidata_p->originator);

    budget--; /* for the '>' sign */

    budget = budget - strlen(uidata_p->destination);

    if(uidata_p->ndigi > 0)
    {
        for(i = 0; i < uidata_p->ndigi; i++)
        {
            budget--; /* for the ',' separator */
            budget = budget - strlen(uidata_p->digipeater[i]);
        }

        /*
         * if the first digi indicates 'digipeated' then there must be
         * a '*' somewhere...
         */
        if((uidata_p->digi_flags[0] & H_FLAG) != 0)
        {
            budget--; /* for the '*' marking somewhere on one of the digis */
        }
    }

    budget--; /* for the ':' header terminator */

    /* see if we have any room left for the payload (we should) */
    if(budget <= 0)
    {
        /* no data to transmit, header took all the space */
        return 0;
    }

    /* look if the packet is too big */
    if(uidata_p->size > budget)
    {
        if(digi_kenwood_mode == 2)
        {
            /* do not transmit too long packets*/
            vsay("Kenwood mode: packet too long, not transmitted\r\n");
            return 0;
        }
        else
        {
            /* truncate the packet to maximum allowable size */
            uidata_p->size = budget;
            vsay("Kenwood mode: packet too long, truncated to %d bytes\r\n",
                    budget);
        }
    }

    /* okay to transmit */
    return 1;
}

/*
 * get disassembled AX.25 from MAC layer
 *
 * returns: 0 if no data is received
 *          1 data received and put in the uidata_p structure
 *          2 data received with unknown PID, data put in the uidata_p struct
 *          3 corrupt data frame received, data in uidata_p not complete
 *         -1 on error (conversion check for debugging)
 */
short get_uidata(uidata_t *uidata_p)
{
    frame_t frame;
#ifdef debug
    frame_t check_frame;
#endif
    short   result;

    while (mac_avl ())
    {
        if(mac_inp(&frame) == 0)
        {
#ifdef debug
            dump_raw(&frame);
#endif

            result = frame2uidata(&frame, uidata_p);

            /* Write to TNC log (if needed) */
            tnc_log(uidata_p, REMOTE); 

            if(result == 1)
            {
                /* frame decoded correctly */
#ifdef debug
                uidata2frame(uidata_p,&check_frame);
                if(frame.port != check_frame.port)
                {
                    vsay("Check: port error, org %d, check %d\r\n",
                            (short) frame.port + 1, (short) check_frame.port + 1);
                    dump_raw(&frame);
                    dump_raw(&check_frame);
                    dump_uidata_from(uidata_p);
                    if(frame2uidata(&check_frame, uidata_p) != 0)
                    {
                        dump_uidata_from(uidata_p);
                    }
                    return -1;
                }
                if(frame.len != check_frame.len)
                {
                    vsay("Check: len error, org %d, check %d\r\n",
                             frame.len, check_frame.len);
                    dump_raw(&frame);
                    dump_raw(&check_frame);
                    dump_uidata_from(uidata_p);
                    if(frame2uidata(&check_frame, uidata_p) != 0)
                    {
                        dump_uidata_from(uidata_p);
                    }
                    return -1;
                }
                if(memcmp(&(frame.frame[0]), &(check_frame.frame[0]),
                        frame.len) != 0)
                {
                    vsay("Check: data error\r\n");
                    dump_raw(&frame);
                    dump_raw(&check_frame);
                    dump_uidata_from(uidata_p);
                    if(frame2uidata(&check_frame, uidata_p) != 0)
                    {
                        dump_uidata_from(uidata_p);
                    }
                    return -1;
                }
#endif
                return 1;
            }
            else if(result == -1)
            {
                /* frame decoded but unknown PID */
                dump_uidata_from(uidata_p);

                if(digi_kenwood_mode == 0)
                {
                    /* only support for AX.25, IP, ARP and NETROM packets */
                    vsay("Not an AX.25, IP, ARP or NETROM packet "
                        "(PID=%X), not handled\r\n", uidata_p->pid);
                }
                else
                {
                    vsay("Kenwood mode: only normal AX.25 UI packets\r\n");
                }

                return 2;
            }
            else if(result == -2)
            {
                /* frame decoded but errors in call */
                dump_uidata_from(uidata_p);

                /* error in frame decoding */
                return 3;
            }
            else
            {
                /* error in frame decoding */
                return 3;
            }
        }
    }
    return 0;
}

/*
 * send disassembled AX.25 frame to MAC layer
 *
 * returns: 0 if MAC layer cannot take the frame
 *          1 if data is sucessfully put into the MAC layer
 */
short put_uidata(uidata_t *uidata_p)
{
    frame_t frame;

    /* Write to TNC log (if needed) */
    tnc_log(uidata_p, uidata_p->distance); 

    /* convert to an AX.25 frame */
    uidata2frame(uidata_p, &frame);

#ifdef debug
    dump_raw(&frame);
#endif

    /* transmit this frame */
    if(mac_out(&frame) == 0)
        return 1; /* success */

    return 0; /* failure */
}

#ifdef _LINUX_
int add_lnx_port(char *port_p)
{
    ports_t         *prt_p;

    if(lnx_port_nr < MAX_PORTS)
    {
        prt_p = &(lnx_port[lnx_port_nr]);

        prt_p->port_p = port_p;

        lnx_port_nr++;

        /* succesfully added */
        return 1;
    }
    else
    {
        /* Can't add more ports */
        return 0;
    }
}
#endif

/*
 * Initialize access to MAC layer
 *
 * returns: 0 if MAC layer cannot be found
 *          1 if MAC layer is found in memory
 */
short init_mac(void)
{
#ifndef _LINUX_
    unsigned char vector, *p1;
    unsigned char far * p2;
    unsigned char far * handler;
    frame_t             frame;

    for (vector = 0xFF; vector >= 0x40; vector--)
    {
        handler = (unsigned char far *) getvect (vector);

        p1 = hdr_mac;

        for (p2 = handler; *p1 == '?' || *p1 == *p2; p2++)
        {
            if (!*++p1)
            {
                mac_vector = ((short) vector) & 0x00ff;

                while(mac_avl())
                {
                    /* flush pending input */
                    (void) mac_inp(&frame);
                }

                return 1;
            }
        }
    }

    return 0;
#else
    struct sockaddr  sa;
    ports_t         *prt_p;
    short            i;

    if(geteuid() != 0)
    {
        display_help_root();
        exit(-1);
    }

    /* general startup, done once */
    if (ax25_config_load_ports() == 0) {
        say("ERROR: problem with axports file\r\n");
        return 0;
    }

    /* convert axport to device and open transmitter sockets */
    for(i = 0; i < lnx_port_nr; i++)
    {
        prt_p = &(lnx_port[i]);

        if ((prt_p->dev_p = ax25_config_get_dev(prt_p->port_p)) == NULL)
        {
            say("ERROR: invalid port name - %s\r\n", prt_p->port_p);
            return 0;
        }

        /* do transmitter side */
        prt_p->s_out = socket(PF_INET, SOCK_PACKET, htons(ETH_P_AX25));
        if (prt_p->s_out < 0)
        {
            perror("tx socket");
            return 0;
        }

        bzero(&sa,sizeof(struct sockaddr));
        strcpy(sa.sa_data, prt_p->dev_p);
        sa.sa_family = AF_INET;
        if (bind(prt_p->s_out, &sa, sizeof(struct sockaddr)) < 0)
        {
            perror("bind");
            close(prt_p->s_out);
            return 0;
        }
    }

    /* open receive socket, one receiver will do for al ports  */
    /*
     * Use ETH_P_AX25 because with PF_AX25 we also will read the data
     * that we transmit ourselfs, that's useless!
     */
    lnx_s_in = socket(PF_INET, SOCK_PACKET, htons(ETH_P_AX25));
    if (lnx_s_in < 0)
    {
        perror("rx socket");
        return 0;
    }

    return 1;
#endif /* _LINUX_ */
}

