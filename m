Return-Path: <linux-kernel-owner+w=401wt.eu-S964771AbWLOUsm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964771AbWLOUsm (ORCPT <rfc822;w@1wt.eu>);
	Fri, 15 Dec 2006 15:48:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964799AbWLOUsm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Dec 2006 15:48:42 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:34439 "EHLO omx2.sgi.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S964771AbWLOUsk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Dec 2006 15:48:40 -0500
From: Aaron Young <ayoung@google.engr.sgi.com>
Message-Id: <200612152048.MAA98809@google.engr.sgi.com>
Subject: Re: [PATCH 3/3] - Add support for acpi_load_table/acpi_unload_table_id
To: jpk@sgi.com (John Keller)
Date: Fri, 15 Dec 2006 12:48:24 -0800 (PST)
Cc: linux-acpi@vger.kernel.org, akpm@osdl.org, len.brown@intel.com,
       tony.luck@intel.com, linux-ia64@vger.kernel.org,
       pcihpd-discuss@lists.sourceforge.net, gregkh@suse.de,
       linux-kernel@vger.kernel.org, ayoung@sgi.com, jes@sgi.com,
       jpk@sgi.com (John Keller)
In-Reply-To: <20061130230410.23614.55659.74300@attica.americas.sgi.com> from "John Keller" at Nov 30, 2006 05:04:10 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



  Per Len's request:

      I understand and agree this project and the contribution         
      are public and that a record of the contribution (including all
      personal information I submit with it, including my sign-off) is
      maintained indefinitely. I thereby license this patch to be
      redistributed under any license (GPL or non-GPL) consistent
      with the project.

  PS. We'd like this to get into 2.6.20. If there's anything
  we (John K. and I) can do to help, please let us know.

  Thanks,

  -Aaron Young

> 
> 
>  This patch makes acpi_load_table() available
>  for use by removing it from the #ifdef ACPI_FUTURE_USAGE.
> 
>  It also adds a new routine used to unload an ACPI table
>  of a given type and "id" - acpi_unload_table_id().
>  The implementation of this new routine was almost a direct
>  copy of existing routine acpi_unload_table() - only difference
>  being that it only removes a specific table id instead of
>  ALL tables of a given type.
>  The SN hotplug driver (sgi_hotplug.c) now uses both of these
>  interfaces to dynamically load and unload SSDT ACPI tables.
> 
> Signed-off-by: Aaron Young <ayoung@sgi.com>
> 
> ---
> 
> Andrew,
>   Can you take this update and replace the current version in
>   your -mm tree:
>    add-support-for-acpi_load_table-acpi_unload_table_id.patch
> 
> Len,
>   What do we need to do to resolve any licensing issues related to
>   these changes?
> 
> Thanks.
> 
> 
> Resend #2
>    Code has been improved to no longer use ACPI "internal" routines
>    (such as acpi_ns_get_next_node()). To this end, a new public interface
>    to obtain the owner_id for a handle was added (acpi_get_id()). It is
>    very similar to existing routine acpi_get_type().
> 
> Resend #1
>    Original send of this patch was outdated and did not have
>    acpi_ut_acquire_mutex() and acpi_ut_release_mutex() calls
>    in acpi_unload_table_id().
> 
> 
>  drivers/acpi/namespace/nsxfobj.c |   44 +++++++++++++++++++++++
>  drivers/acpi/tables/tbxface.c    |   54 ++++++++++++++++++++++++++++-
>  include/acpi/acpixf.h            |    7 ++-
>  3 files changed, 102 insertions(+), 3 deletions(-)
> 
> Index: release/drivers/acpi/tables/tbxface.c
> ===================================================================
> --- release.orig/drivers/acpi/tables/tbxface.c	2006-11-29 14:14:23.532910707 -0600
> +++ release/drivers/acpi/tables/tbxface.c	2006-11-29 14:15:04.173937975 -0600
> @@ -123,7 +123,6 @@ acpi_status acpi_load_tables(void)
>  
>  ACPI_EXPORT_SYMBOL(acpi_load_tables)
>  
> -#ifdef ACPI_FUTURE_USAGE
>  /*******************************************************************************
>   *
>   * FUNCTION:    acpi_load_table
> @@ -221,6 +220,59 @@ ACPI_EXPORT_SYMBOL(acpi_load_table)
>  
>  /*******************************************************************************
>   *
> + * FUNCTION:    acpi_unload_table_id
> + *
> + * PARAMETERS:  table_type    - Type of table to be unloaded
> + *              id            - Owner ID of the table to be removed.
> + *
> + * RETURN:      Status
> + *
> + * DESCRIPTION: This routine is used to force the unload of a table (by id)
> + *
> + ******************************************************************************/
> +acpi_status acpi_unload_table_id(acpi_table_type table_type, acpi_owner_id id)
> +{
> +	struct acpi_table_desc *table_desc;
> +	acpi_status status;
> +
> +	ACPI_FUNCTION_TRACE(acpi_unload_table);
> +
> +	/* Parameter validation */
> +	if (table_type > ACPI_TABLE_ID_MAX)
> +		return_ACPI_STATUS(AE_BAD_PARAMETER);
> +
> +	/* Find table from the requested type list */
> +	table_desc = acpi_gbl_table_lists[table_type].next;
> +	while (table_desc && table_desc->owner_id != id)
> +		table_desc = table_desc->next;
> +
> +	if (!table_desc)
> +		return_ACPI_STATUS(AE_NOT_EXIST);
> +
> +	/*
> +	 * Delete all namespace objects owned by this table. Note that these
> +	 * objects can appear anywhere in the namespace by virtue of the AML
> +	 * "Scope" operator. Thus, we need to track ownership by an ID, not
> +	 * simply a position within the hierarchy
> +	 */
> +	acpi_ns_delete_namespace_by_owner(table_desc->owner_id);
> +
> +	status = acpi_ut_acquire_mutex(ACPI_MTX_TABLES);
> +	if (ACPI_FAILURE(status))
> +		return_ACPI_STATUS(status);
> +
> +	(void)acpi_tb_uninstall_table(table_desc);
> +
> +	(void)acpi_ut_release_mutex(ACPI_MTX_TABLES);
> +
> +	return_ACPI_STATUS(AE_OK);
> +}
> +
> +ACPI_EXPORT_SYMBOL(acpi_unload_table_id)
> +
> +#ifdef ACPI_FUTURE_USAGE
> +/*******************************************************************************
> + *
>   * FUNCTION:    acpi_unload_table
>   *
>   * PARAMETERS:  table_type    - Type of table to be unloaded
> Index: release/include/acpi/acpixf.h
> ===================================================================
> --- release.orig/include/acpi/acpixf.h	2006-11-29 14:14:23.556913676 -0600
> +++ release/include/acpi/acpixf.h	2006-11-29 14:18:55.966606388 -0600
> @@ -97,11 +97,12 @@ acpi_find_root_pointer(u32 flags, struct
>  
>  acpi_status acpi_load_tables(void);
>  
> -#ifdef ACPI_FUTURE_USAGE
>  acpi_status acpi_load_table(struct acpi_table_header *table_ptr);
>  
> -acpi_status acpi_unload_table(acpi_table_type table_type);
> +acpi_status acpi_unload_table_id(acpi_table_type table_type, acpi_owner_id id);
>  
> +#ifdef ACPI_FUTURE_USAGE
> +acpi_status acpi_unload_table(acpi_table_type table_type);
>  acpi_status
>  acpi_get_table_header(acpi_table_type table_type,
>  		      u32 instance, struct acpi_table_header *out_table_header);
> @@ -180,6 +181,8 @@ acpi_get_next_object(acpi_object_type ty
>  
>  acpi_status acpi_get_type(acpi_handle object, acpi_object_type * out_type);
>  
> +acpi_status acpi_get_id(acpi_handle object, acpi_owner_id * out_type);
> +
>  acpi_status acpi_get_parent(acpi_handle object, acpi_handle * out_handle);
>  
>  /*
> Index: release/drivers/acpi/namespace/nsxfobj.c
> ===================================================================
> --- release.orig/drivers/acpi/namespace/nsxfobj.c	2006-11-29 14:18:31.000000000 -0600
> +++ release/drivers/acpi/namespace/nsxfobj.c	2006-11-29 14:19:18.709418875 -0600
> @@ -50,6 +50,50 @@ ACPI_MODULE_NAME("nsxfobj")
>  
>  /*******************************************************************************
>   *
> + * FUNCTION:    acpi_get_id
> + *
> + * PARAMETERS:  Handle          - Handle of object whose id is desired
> + *              ret_id          - Where the id will be placed
> + *
> + * RETURN:      Status
> + *
> + * DESCRIPTION: This routine returns the owner id associated with a handle
> + *
> + ******************************************************************************/
> +acpi_status acpi_get_id(acpi_handle handle, acpi_owner_id * ret_id)
> +{
> +	struct acpi_namespace_node *node;
> +	acpi_status status;
> +
> +	/* Parameter Validation */
> +
> +	if (!ret_id) {
> +		return (AE_BAD_PARAMETER);
> +	}
> +
> +	status = acpi_ut_acquire_mutex(ACPI_MTX_NAMESPACE);
> +	if (ACPI_FAILURE(status)) {
> +		return (status);
> +	}
> +
> +	/* Convert and validate the handle */
> +
> +	node = acpi_ns_map_handle_to_node(handle);
> +	if (!node) {
> +		(void)acpi_ut_release_mutex(ACPI_MTX_NAMESPACE);
> +		return (AE_BAD_PARAMETER);
> +	}
> +
> +	*ret_id = node->owner_id;
> +
> +	status = acpi_ut_release_mutex(ACPI_MTX_NAMESPACE);
> +	return (status);
> +}
> +
> +ACPI_EXPORT_SYMBOL(acpi_get_id)
> +
> +/*******************************************************************************
> + *
>   * FUNCTION:    acpi_get_type
>   *
>   * PARAMETERS:  Handle          - Handle of object whose type is desired
> 

