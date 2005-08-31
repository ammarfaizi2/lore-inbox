Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964803AbVHaOzv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964803AbVHaOzv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Aug 2005 10:55:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932380AbVHaOzv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Aug 2005 10:55:51 -0400
Received: from dilbert.robsims.com ([209.120.158.98]:47882 "EHLO
	mail.robsims.com") by vger.kernel.org with ESMTP id S932349AbVHaOzu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Aug 2005 10:55:50 -0400
Date: Wed, 31 Aug 2005 08:55:45 -0600
From: Rob Sims <lkml-z@robsims.com>
To: linux-kernel@vger.kernel.org
Subject: Change in NFS client behavior
Message-ID: <20050831145545.GA8426@robsims.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We have noticed when changing from kernel 2.4.23 to 2.6.8 that
timestamps of files are not changed if opened for a write and nothing is
written.  When using 2.4.23 timestamps are changed.  When using a local
filesystem (reiserfs) with either kernel, timestamps are changed.
Symptoms vary with the client, not the server.  See the script below.

When run on a 2.4.23 machine in an NFS mounted directory, output is
"Good."  When run on a 2.6.8 or 2.6.12-rc4 machine in an NFS directory,
output is "Error."

Is this a bug?  How do we revert to the 2.4/local fs behavior?  

Thanks,
Rob

#!/bin/sh

if [ -n "$1" ]; then
  if [ -e "$1" ]; then
    printf "%s exists - please specify a new file name.\n" "$1"
  else
    touch $1
    origtime=`stat -c '%X %Y %Z' "$1"`
    sleep 5
    cat /dev/null > "$1"
    newtime=`stat -c '%X %Y %Z' "$1"`
    rm "$1"

    printf "%s\n%s\n" "$origtime" "$newtime"
    if [ "$origtime" = "$newtime" ]; then
      printf "Error - timestamps not modified\n"
    else
      printf "Good - timestamps modified\n"
    fi
  fi
else
  printf "Please specify a file name.\n"
fi
