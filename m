Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261612AbVBKXLJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261612AbVBKXLJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Feb 2005 18:11:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262178AbVBKXLJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Feb 2005 18:11:09 -0500
Received: from relay.axxeo.de ([213.239.199.237]:62434 "EHLO relay.axxeo.de")
	by vger.kernel.org with ESMTP id S261612AbVBKXK7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Feb 2005 18:10:59 -0500
From: Ingo Oeser <ioe-lkml@axxeo.de>
To: Alasdair G Kergon <agk@redhat.com>
Subject: Re: [PATCH] device-mapper: multipath hardware handler
Date: Sat, 12 Feb 2005 00:10:52 +0100
User-Agent: KMail/1.7.1
References: <20050211171910.GZ10195@agk.surrey.redhat.com>
In-Reply-To: <20050211171910.GZ10195@agk.surrey.redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200502120010.52086.ioe-lkml@axxeo.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alasdair,

Alasdair G Kergon wrote:
> +/*
> + * Constructs a hardware handler object, takes custom arguments
> + */
> +typedef int (*hwh_ctr_fn) (struct hw_handler *hwh, unsigned arc, char
> **argv); +typedef void (*hwh_dtr_fn) (struct hw_handler *hwh);
> +
> +typedef void (*hwh_pg_init_fn) (struct hw_handler *hwh, unsigned bypassed,
> +    struct path *path);
> +typedef unsigned (*hwh_err_fn) (struct hw_handler *hwh, struct bio *bio);
> +typedef int (*hwh_status_fn) (struct hw_handler *hwh,
> +         status_type_t type,
> +         char *result, unsigned int maxlen);
> +
> +/* Information about a hardware handler type */
> +struct hw_handler_type {
> + char *name;
> + struct module *module;
> +
> + hwh_ctr_fn ctr;
> + hwh_dtr_fn dtr;
> +
> + hwh_pg_init_fn pg_init;
> + hwh_err_fn err;
> + hwh_status_fn status;
> +};

Please loose the prototypes, don't use prefixes/suffixes and use more 
descriptive names. Reasons are in Documentation/CodingStyle, Chapter 4.

So I suggest declaring it like this:

struct hardware_handler_operations {
 char *name;
 struct module *module;

 int (*create) (struct hw_handler *handler, unsigned int argc, char **argv);
 void (*destroy) (struct hw_handler *handler);

 void (*pg_init) (struct hw_handler *handler, unsigned int bypassed, 
                           struct path *path);

 unsigned (*error) (struct hw_handler *hwh, struct bio *bio);
 int (*status) (struct hw_handler *hwh, status_type_t type,  char *result, 
      unsigned int maxlen);
};

But you might want to loose status_type_t, too. Also hw_foo is a bit generic, 
isn't it? We are all dealing with "hardware" in any driver (which is 
basically another word for "hardware handler"). So please be a bit more 
creative on WHAT you drive.


Regards

Ingo Oeser

