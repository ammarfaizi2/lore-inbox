Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262264AbVCIGdG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262264AbVCIGdG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 01:33:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262333AbVCIGcr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 01:32:47 -0500
Received: from waste.org ([216.27.176.166]:41659 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S261631AbVCIGcK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 01:32:10 -0500
Date: Tue, 8 Mar 2005 22:32:09 -0800
From: Matt Mackall <mpm@selenic.com>
To: Alex Aizman <itn780@yahoo.com>
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE 2/6] Open-iSCSI High-Performance Initiator for Linux
Message-ID: <20050309063209.GV3163@waste.org>
References: <422BFEC6.70305@yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <422BFEC6.70305@yahoo.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 06, 2005 at 11:12:06PM -0800, Alex Aizman wrote:

> +#define iscsi_ptr(_handle) ((void*)(unsigned long)_handle)
> +#define iscsi_handle(_ptr) ((uint64_t)(unsigned long)_ptr)

This is a bit wonky. Why is there a distinction?


> +#ifndef ISCSI_PROTO_H
> +#define ISCSI_PROTO_H
> +
> +#define ISCSI_VERSION_STR	"0.1.0"
> +#define ISCSI_DATE_STR		"17-Jan-2005"
> +#define ISCSI_DRAFT20_VERSION	0x00
> +
> +/* default iSCSI listen port for incoming connections */
> +#define ISCSI_LISTEN_PORT	3260
> +
> +/* Padding word length */
> +#define PAD_WORD_LEN		4

Namespace.

> +
> +/*
> + * useful common(control and data pathes) macro
> + */
> +#define ntoh24(p) (((p)[0] << 16) | ((p)[1] << 8) | ((p)[2]))
> +#define hton24(p, v) { \
> +        p[0] = (((v) >> 16) & 0xFF); \
> +        p[1] = (((v) >> 8) & 0xFF); \
> +        p[2] = ((v) & 0xFF); \
> +}
> +#define zero_data(p) {p[0]=0;p[1]=0;p[2]=0;}

These are specific to dlength, yes? Can we instead roll dlength and
hlength together, and do this with masking?

#define iscsi_hlen(hdr) (ntohl(hdr->hdlen)>>24)
#define iscsi_dlen(hdr) (ntohl(hdr->hdlen) & 0xffffff)
#define iscsi_set_hlen(hdr, len) (hdr->hdlen=htonl(iscsi_dlen(hdr)|(len<<24)))
#define iscsi_set_hlen(hdr, len) (hdr->hdlen=htonl(len|(iscsi_hlen(hdr)<<24)))

The last two obviously have multiple evaluation, but you get the idea.

> +/* SNACK Header */

Mmm, snacks.

> +/* Reason for Reject */
> +#define CMD_BEFORE_LOGIN	1
> +#define DATA_DIGEST_ERROR	2
> +#define DATA_SNACK_REJECT	3
> +#define ISCSI_PROTOCOL_ERROR	4
> +#define CMD_NOT_SUPPORTED	5
> +#define IMM_CMD_REJECT		6
> +#define TASK_IN_PROGRESS	7
> +#define INVALID_SNACK		8
> +#define BOOKMARK_REJECTED	9
> +#define BOOKMARK_NO_RESOURCES	10
> +#define NEGOTIATION_RESET	11
> +
> +/* Max. number of Key=Value pairs in a text message */
> +#define MAX_KEY_VALUE_PAIRS	8192
> +
> +/* maximum length for text keys/values */
> +#define KEY_MAXLEN		64
> +#define VALUE_MAXLEN		255
> +#define TARGET_NAME_MAXLEN	VALUE_MAXLEN
> +
> +#define DEFAULT_MAX_RECV_DATA_SEGMENT_LENGTH	8192

Namespace.

-- 
Mathematics is the supreme nostalgia of our time.
